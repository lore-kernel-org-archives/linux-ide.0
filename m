From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 14:48:16 +0200
Message-ID: <20080826124816.GA20055@kernel.dk>
References: <20080826072841.GS20055@kernel.dk> <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk> <20080826101713.GW20055@kernel.dk> <48B3F7C3.6010600@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [93.163.65.50] ([93.163.65.50]:2946 "EHLO kernel.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756278AbYHZMsT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 08:48:19 -0400
Content-Disposition: inline
In-Reply-To: <48B3F7C3.6010600@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, tj@kernel.org, linux-ide@vger.kernel.org

On Tue, Aug 26 2008, Brad Campbell wrote:
> Jens 2 wrote:
> >On Tue, Aug 26 2008, Alan Cox wrote:
> >>>a) Why was this limit put in there? It limits both transfer speed and
> >>>   request size. If it's due to some dodgy drive/bridge, perhaps we
> >>>   should just check for that and only apply the transfer limits when
> >>>   detected (or blacklisted). On the bridge setups I've seen, I've never
> >>>   had problems with killing the limit.
> >>Various old bridges need it - and you can't detect the bridge type.
> >
> >Not generically, but for some devices (like the Mtron) we can.
> >
> >>>b) Put in a whitelist, easy to do for these Mtron drives.
> >>>
> >>>c) Add a parameter to turn it on (or off, depending on the default) for
> >>>   a specific drive.
> >>>
> >>>I'm in favor of a) personally, but I'd like to hear why the check was
> >>>added originally first. Dropping 20-30% of the throughput performance on
> >>>the floor without option seems like a really bad choice.
> 
> The check was originally put there as some nasty bridges caused all sorts 
> of errors when these limits were exceeded, including some random data 
> corruption from memory.
> 
> Those particular bridges were/are still widely available an can't be 
> detected / identified using any other means.

That's a worry, since I don't think we can dynamically switch back in
that case if it has potential data corruption problems.

> >>Can I suggest 
> >>
> >>d) Assume the bridge is ok but teach the SATA error handling code that if
> >>there is a timeout immediately with such a bridge then to flip down to
> >>UDMA5 and knobble the transfer length.
> >
> >That would be nice, assuming that we can rely on safe behaviour (eg not
> >data corrupting badness).
> >
> 
> I was responsible for that original bridge knobble stuff and fortunately I 
> still have the bridges, disks and controllers that triggered the original 
> faults. If someone wants to cook up some code for testing I'd be more than 
> happy to stick this stuff on the bench and beat on it for regression 
> purposes.

Given that this problem should be going away and that it only really
matters on very select devices (like this SSD), I think we should just
add a quick white list for the bridge limits.

Below is a quick'n dirty for that...

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 79e3a8e..fe8033a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2097,9 +2097,70 @@ retry:
 	return rc;
 }
 
+struct ata_blacklist_entry {
+	const char *model_num;
+	const char *model_rev;
+	unsigned long horkage;
+};
+
+static const struct ata_blacklist_entry ata_bridge_whitelist[] = {
+	/*
+	 * The following devices sit behind a bridge, but don't need
+	 * transfer rate or size limits applied.
+	 */
+	{ "Mtron", },
+
+	/* End Marker */
+	{ }
+};
+
+static int strn_pattern_cmp(const char *patt, const char *name, int wildchar)
+{
+	const char *p;
+	int len;
+
+	/*
+	 * check for trailing wildcard: *\0
+	 */
+	p = strchr(patt, wildchar);
+	if (p && ((*(p + 1)) == 0))
+		len = p - patt;
+	else {
+		len = strlen(name);
+		if (!len) {
+			if (!*patt)
+				return 0;
+			return -1;
+		}
+	}
+
+	return strncmp(patt, name, len);
+}
+
+static unsigned int ata_dev_bridge_whitelisted(const struct ata_device *dev)
+{
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
+	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
+	const struct ata_blacklist_entry *ad = ata_bridge_whitelist;
+
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
+	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
+
+	while (ad->model_num) {
+		if (!strn_pattern_cmp(ad->model_num, model_num, '*'))
+			return 1;
+		ad++;
+	}
+	return 0;
+}
+
 static inline u8 ata_dev_knobble(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
+
+	if (ata_dev_bridge_whitelisted(dev))
+		return 0;
+
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
@@ -3913,12 +3974,6 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 	return rc;
 }
 
-struct ata_blacklist_entry {
-	const char *model_num;
-	const char *model_rev;
-	unsigned long horkage;
-};
-
 static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices with DMA related problems under Linux */
 	{ "WDC AC11000H",	NULL,		ATA_HORKAGE_NODMA },
@@ -4002,29 +4057,6 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ }
 };
 
-static int strn_pattern_cmp(const char *patt, const char *name, int wildchar)
-{
-	const char *p;
-	int len;
-
-	/*
-	 * check for trailing wildcard: *\0
-	 */
-	p = strchr(patt, wildchar);
-	if (p && ((*(p + 1)) == 0))
-		len = p - patt;
-	else {
-		len = strlen(name);
-		if (!len) {
-			if (!*patt)
-				return 0;
-			return -1;
-		}
-	}
-
-	return strncmp(patt, name, len);
-}
-
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];

-- 
Jens Axboe


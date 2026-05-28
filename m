Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901E19A288
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000016; cv=none; b=MoB0Kb1ZZ1YUAi1AVhMmWsG/sTqfkeYIekGNpDD5p4UtCfUPI2lUanFxgMcj8mm0wIIatqTnu6nBR2vTsfZjqL5Itpi3V40vjvajiqgMqNIwm8tmn2MCfkCVXVqrta7ygcxjbZR994hrPPv1uYJ3mtUV+cHSooQCx2V5zMQNFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000016; c=relaxed/simple;
	bh=sVt+KgXwQwLYS3uHfGTXUgjnu+E+nYkcTK0JQI9qBI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU3O615Xfnu3nrmC/c/UOod9yAhWXVGXELms8SUQI6ZSovCyho1PvDg11AYj1k3t10vSM6jhV4Xwq/oxAS7M2w7Jm0jdAlSeECoRgk8RWyfjrCqmyXLgGJHKgd4gZqF1YcJqHtW2l2vS3/k3Rah7Jn/CwAPTW7gRAtnFW7hhYFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxhlJjv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxhlJjv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014DE1F00A3A;
	Thu, 28 May 2026 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780000015;
	bh=K5Bf4vR1agJiTWyWmkguxEgDgtpkIyfYO+QxfVlj65A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UxhlJjv37ubk41EXY6/XN9kJmRgQJnEyV7V0ELLag58Gf2WOgcR/m8UQjTWilGJ2f
	 ICtF576bM4FsytrDsvV7zntmq9Jf4Fl9khHZOBBkcFyC87G64+e0dT5QATHgsybc9e
	 0oQsJF4EX+221CvYfEpV1Y3ccfLATvbfOINX3FVEz0MTLSe7iJCZu+tven7bve0XGt
	 40l8jW/tKWcdASqeC+VotmMrcATFHiEjcnjkPaYnzDfKnt67meHSpfinzlijO2D3Ob
	 tPO27fYoZ7ZlEdtgSga7Q7Ap/dhwIEaCVWKqgER5AL4QAKcTmI4tePAZxgIiIbrGTw
	 iWTfFBmzSneuQ==
Date: Thu, 28 May 2026 22:26:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>, Hannes Reinecke <hare@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Viresh Kumar <vireshk@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v4] ata: libata: Document when host->eh_mutex should be
 held
Message-ID: <ahilCt1I-kns__DV@ryzen>
References: <230fb523796cd9c1643c5673bddb45fc48eb9514.1779990228.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230fb523796cd9c1643c5673bddb45fc48eb9514.1779990228.git.bvanassche@acm.org>

On Thu, May 28, 2026 at 10:47:26AM -0700, Bart Van Assche wrote:
> Annotate the following functions with __must_hold(&host->eh_mutex):
>  * All ata_port_operations.error_handler() implementations.
>  * ata_eh_reset() and ata_eh_recover() because these functions call
>    ata_eh_release() and ata_eh_acquire().
>  * All callers of ata_eh_reset() and ata_eh_recover().
> 
> Enable Clang's context analysis. This will cause the build to fail if
> e.g. a locking bug would be introduced in an error path. This patch
> should not affect the generated assembler code.
> 
> Note: although the Linux kernel documentation specifies 22 as minimal
> version for Clang for context analysis support, annotating function
> pointers is a Clang 23 feature. As one can see here, a patch has been
> queued that fixes the kernel documentation:
> https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-bot2@tip-bot2/
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

After spending the whole day playing with Clang 23, personally I do prefer
growing an ap parameter in ata_eh_reset() (in a patch 1/2), because it will
avoid us having to add two lockdep_assert_held() (which we know, from context
analysis PoV, just fools the compiler to say that we have the lock, without
actually verifying anything. (Yes, when running lockdep in runtime, it
would be verified.)

But at least with an ap parameter to ata_eh_reset(), context analysis will
actually work, and will allow us to verify things already in compile time.
No lockdep needed. Don't get me wrong, lockdep is awesome, but if we can
verify things already in compile time in an easy way, that seems way better
IMO. Let's leave the runtime checking for things that we can't trivially
verify during compile time.

I.e. the diff would be something like this compared to your V4:


diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8b5fd2a48660..a66663d3579e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2833,11 +2833,10 @@ static bool ata_eh_followup_srst_needed(struct ata_link *link, int rc)
 	return false;
 }
 
-int ata_eh_reset(struct ata_link *link, int classify,
+int ata_eh_reset(struct ata_port *ap, struct ata_link *link, int classify,
 		 struct ata_reset_operations *reset_ops)
-	__must_hold(&link->ap->host->eh_mutex)
+	__must_hold(&ap->host->eh_mutex)
 {
-	struct ata_port *ap = link->ap;
 	struct ata_link *slave = ap->slave_link;
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_eh_context *sehc = slave ? &slave->eh_context : NULL;
@@ -3883,12 +3882,11 @@ int ata_eh_recover(struct ata_port *ap, struct ata_reset_operations *reset_ops,
 	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc = &link->eh_context;
 
-		lockdep_assert_held(&link->ap->host->eh_mutex);
-
 		if (!(ehc->i.action & ATA_EH_RESET))
 			continue;
 
-		rc = ata_eh_reset(link, ata_link_nr_vacant(link), reset_ops);
+		rc = ata_eh_reset(ap, link, ata_link_nr_vacant(link),
+				  reset_ops);
 		if (rc) {
 			ata_link_err(link, "reset failed, giving up\n");
 			goto out;
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index bf40633f8fb2..188fc12c2704 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -751,8 +751,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	int detach = 0, rc = 0;
 	int reval_failed = 0;
 
-	lockdep_assert_held(&ap->link.ap->host->eh_mutex);
-
 	if (dev->flags & ATA_DFLAG_DETACH) {
 		detach = 1;
 		rc = -ENODEV;
@@ -766,7 +764,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 		struct ata_link *tlink;
 
 		/* reset */
-		rc = ata_eh_reset(link, 0, reset_ops);
+		rc = ata_eh_reset(ap, link, 0, reset_ops);
 		if (rc) {
 			ata_link_err(link, "failed to reset PMP, giving up\n");
 			goto fail;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 9e3817a1b143..0dd735c2e5b5 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -192,9 +192,9 @@ extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 extern void ata_eh_autopsy(struct ata_port *ap);
 const char *ata_get_cmd_name(u8 command);
 extern void ata_eh_report(struct ata_port *ap);
-extern int ata_eh_reset(struct ata_link *link, int classify,
-			struct ata_reset_operations *reset_ops)
-	__must_hold(&link->ap->host->eh_mutex);
+extern int ata_eh_reset(struct ata_port *ap, struct ata_link *link,
+			int classify, struct ata_reset_operations *reset_ops)
+	__must_hold(&ap->host->eh_mutex);
 extern int ata_eh_recover(struct ata_port *ap,
 			  struct ata_reset_operations *reset_ops,
 			  struct ata_link **r_failed_disk)



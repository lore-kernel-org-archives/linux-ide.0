From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC v3 08/13] ahci-platform: Allow specifying platform_data
	through of_device_id
Date: Sun, 19 Jan 2014 12:30:55 +0000
Message-ID: <20140119123055.GO15937@n2100.arm.linux.org.uk>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-9-git-send-email-hdegoede@redhat.com> <20140119113838.GE11123@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41733 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751358AbaASMbB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jan 2014 07:31:01 -0500
Content-Disposition: inline
In-Reply-To: <20140119113838.GE11123@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, devicetree <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-sunxi@googlegroups.com, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Sun, Jan 19, 2014 at 06:38:38AM -0500, Tejun Heo wrote:
> On Sun, Jan 19, 2014 at 12:48:50AM +0100, Hans de Goede wrote:
> > @@ -126,7 +151,7 @@ static void ahci_put_clks(struct ahci_host_priv *hpriv)
> >  static int ahci_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	struct ahci_platform_data *pdata = dev_get_platdata(dev);
> > +	const struct ahci_platform_data *pdata = ahci_get_pdata(dev);
> 
> Let's please not add const.  For data types which are known to be
> terminal, const more or less works, I suppose but for anything even
> mildly complicated it ends up being more of a headache.  C just
> doesn't have enough language support to make const actually useful.
> e.g. now if somebody wants to add an accessor to ahci_platform_data()
> which is applicable to both readers and writers, we either need two
> separate accessors for const and !const paths or have to cast away
> const.

I don't see anything wrong with this.  Platform data should _never_ be
written to, because doing so will change the driver behaviour between
bindings.  It really should be read-only to driver code.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

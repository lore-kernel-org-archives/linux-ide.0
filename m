From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 00/13] ahci: add sunxi driver and cleanup imx driver
Date: Sun, 19 Jan 2014 00:48:42 +0100
Message-ID: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB4FF5SLAKGQEMB5CLXY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi All,

Here is v3 of my patchset for adding ahci-sunxi support. It has grown quite
a bit since I've been going for a more generic approach this time and I've
also cleaned up the ahci-imx driver to use the same generic approach.

History:

v1, by Olliver Schinagl:
This was using the approach of having a platform device which probe method
creates a new child platform device which gets driven by ahci_platform.c,
as done by ahci_imx.c .

v2, by Hans de Goede:
Stand-alone platform driver based on Olliver's work

v3, by Hans de Goede:
patch-series, with 4 different parts
a) Make ahci_platform.c more generic, handle more then 1 clk, target pwr
   regulator
b) New ahci-sunxi code only populating ahci_platform_data, passed to
   ahci_platform.c to of_device_id matching.
c) Refactor ahci-imx code to work the same as the new ahci-sunxi code, this
   is the reason why v3 is an RFC, I'm waiting for the wandboard I ordered to
   arrive so that I can actually test this.
d) dts bindings for the sunxi ahci parts

Parts a-c are intended for merging through the ata tree, the dts bindings
will be merged to Maxime Ripard's sunxi-dts tree.

I hope people like the new approach for dealing with of drivers which need
to provide ahci_platform_data. An alternate approach would be to export
ahci_probe (renamed to ahci_platform_probe) from ahci_platform.c, then
ahci_sunxi.c could have a probe function like this:

int ahci_sunxi_probe(struct platform_device *pdev) {
    pdev->dev.platform_data = &ahci_sunxi_pdata;
    return ahci_platform_probe(pdev);
}

And then each of ahci_platform, ahci_sunxi and ahci_imx could be its own
module (if build as module) rather then all of them being build into one
module.

Regards,

Hans

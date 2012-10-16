From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 6/6] ARM: EXYNOS5: SATA PHY controller driver
Date: Tue, 16 Oct 2012 12:02:14 +0200
Message-ID: <2178134.oExSl5aWTm@amdc1227>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
 <10179968.slaZyPIETn@flatron>
 <CAK1UHiw8+ebzGyjV53Y9efpMFPbCL9RR_o9ZSw=NTuRw_9gRwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2653589176884717231=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <CAK1UHiw8+ebzGyjV53Y9efpMFPbCL9RR_o9ZSw=NTuRw_9gRwg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vasanth Ananthan <vasanthananthan@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, Vasanth Ananthan <vasanth.a@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-ide@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

--===============2653589176884717231==
Content-type: multipart/alternative; boundary=nextPart2826037.xbMqiPxAPu
Content-transfer-encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart2826037.xbMqiPxAPu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Vasanth,

On Tuesday 16 of October 2012 12:03:47 Vasanth Ananthan wrote:
> Hi Tomasz,
> 
> On Sat, Oct 13, 2012 at 4:20 AM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > Hi,
> > 
> > On Tuesday 09 of October 2012 17:18:52 Vasanth Ananthan wrote:
> >> This patch adds a platform driver and I2C client driver for SATA PHY
> >> controller
> >> 
> >> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> >> ---
> >> 
> >>  drivers/ata/Makefile          |    2 +-
> >>  drivers/ata/sata_exynos_phy.c |  303
> >> 
> >> +++++++++++++++++++++++++++++++++++++++++ 2 files changed, 304
> >> insertions(+), 1 deletions(-)
> >> 
> >>  create mode 100644 drivers/ata/sata_exynos_phy.c
> 
> [ ... ]
> 
> >> +
> >> +     phy->init = sataphy_init;
> >> +     phy->shutdown = sataphy_shutdown;
> >> +     phy->priv_data = (void *)sataphy;
> >> +     phy->dev = &pdev->dev;
> >> +
> >> +     ret = sata_add_phy(phy, SATA_PHY_GENERATION3);
> >> +     if (ret < 0)
> >> +             goto err4;
> > 
> > Do you have any warranties that phy callbacks won't get called before
> > i2c device probes and sets i2c_client?
> > 
> >> +
> >> +     ret = i2c_add_driver(&sataphy_i2c_driver);
> >> +     if (ret < 0)
> >> +             goto err5;
> >> +
> >> +     platform_set_drvdata(pdev, phy);
> 
> I shall register my i2c client driver before assigning the SATA PHY
> call backs. Would that guarantee the calling of phy callbacks after
> the i2c device probes?

No. You might still not have the sata phy i2c controller registered at 
that time and so the i2c driver will not be probed.

The only definitive solution for this would be to register both platform 
and i2c drivers in module init (instead of using module_platform_driver) 
and defer the probe of platform driver until i2c device gets registered. 

You can defer the probe by returning -EPROBE_DEFER after checking that 
i2c_client is still NULL.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center

--nextPart2826037.xbMqiPxAPu
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="us-ascii"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'Monospace'; font-size:9pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Hi Vasanth,</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Tuesday 16 of October 2012 12:03:47 Vasanth Ananthan wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Hi Tomasz,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; On Sat, Oct 13, 2012 at 4:20 AM, Tomasz Figa &lt;tomasz.figa@gmail.com&gt; wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; Hi,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; On Tuesday 09 of October 2012 17:18:52 Vasanth Ananthan wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; This patch adds a platform driver and I2C client driver for SATA PHY</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; controller</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; Signed-off-by: Vasanth Ananthan &lt;vasanth.a@samsung.com&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; ---</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;  drivers/ata/Makefile          |    2 +-</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;  drivers/ata/sata_exynos_phy.c |  303</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +++++++++++++++++++++++++++++++++++++++++ 2 files changed, 304</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; insertions(+), 1 deletions(-)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;  create mode 100644 drivers/ata/sata_exynos_phy.c</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; [ ... ]</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +     phy-&gt;init = sataphy_init;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +     phy-&gt;shutdown = sataphy_shutdown;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +     phy-&gt;priv_data = (void *)sataphy;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +     phy-&gt;dev = &amp;pdev-&gt;dev;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +     ret = sata_add_phy(phy, SATA_PHY_GENERATION3);</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +     if (ret &lt; 0)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +             goto err4;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; Do you have any warranties that phy callbacks won't get called before</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; i2c device probes and sets i2c_client?</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +     ret = i2c_add_driver(&amp;sataphy_i2c_driver);</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +     if (ret &lt; 0)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +             goto err5;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; +     platform_set_drvdata(pdev, phy);</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; I shall register my i2c client driver before assigning the SATA PHY</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; call backs. Would that guarantee the calling of phy callbacks after</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; the i2c device probes?</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">No. You might still not have the sata phy i2c controller registered at that time and so the i2c driver will not be probed.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">The only definitive solution for this would be to register both platform and i2c drivers in module init (instead of using module_platform_driver) and defer the probe of platform driver until i2c device gets registered. </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">You can defer the probe by returning -EPROBE_DEFER after checking that i2c_client is still NULL.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Best regards,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">-- </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Tomasz Figa</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Samsung Poland R&amp;D Center</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p></body></html>
--nextPart2826037.xbMqiPxAPu--



--===============2653589176884717231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2653589176884717231==--

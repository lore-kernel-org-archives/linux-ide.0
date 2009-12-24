From: Tejun Heo <tj@kernel.org>
Subject: Re: Long delays while hibernating
Date: Thu, 24 Dec 2009 16:45:26 +0900
Message-ID: <4B331C16.4080901@kernel.org>
References: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>	 <4B31CAF9.8070104@kernel.org> <74fd948d0912230550i639f7c05m9a6e5c9996479c01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050304030502080109020001"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34396 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754336AbZLXHlu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Dec 2009 02:41:50 -0500
In-Reply-To: <74fd948d0912230550i639f7c05m9a6e5c9996479c01@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050304030502080109020001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/23/2009 10:50 PM, Pedro Ribeiro wrote:
>> Can you please attach the output of dmidecode?
> 
> Thanks for the quick reply, here is what you requested.
> http://pastebin.com/m72748645

Can you please try the attached patch?

Thanks.

-- 
tejun

--------------050304030502080109020001
Content-Type: text/x-patch;
 name="tp-t400-broken-suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tp-t400-broken-suspend.patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 19136a7..a90d52f 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1085,6 +1085,13 @@ static int piix_broken_suspend(void)
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-BX297XP"),
 			},
 		},
+		{
+			.ident = "ThinkPad T400",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "7417PLU"),
+			},
+		},
 
 		{ }	/* terminate list */
 	};

--------------050304030502080109020001--

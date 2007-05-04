From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Fri, 04 May 2007 21:36:28 +0200
Message-ID: <463B8B3C.9010509@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com> <463B019E.7010700@gmail.com> <463B71FA.8090005@gmail.com> <463B74DB.8060509@gmail.com> <463B89B9.8050104@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010905050707090900000006"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:25844 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423104AbXEDTgi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 15:36:38 -0400
Received: by nz-out-0506.google.com with SMTP id o1so969500nzf
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 12:36:38 -0700 (PDT)
In-Reply-To: <463B89B9.8050104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de

This is a multi-part message in MIME format.
--------------010905050707090900000006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Matí­as Alejandro Torres wrote:
> 
>> Well, making it work without pci=nomsi is the whole point here.  I dunno
>> why this simple thing doesn't work.  Can you post the result of 'lspci
>> -nn' so that we can see the numeric ID?
>>   
> I would really like to know the answer to that, but i'm hundred of miles
> away. Attached to this email is the output of  lspci -nn .
> 
> Maybe you have the wrong id of the pci bridge:
> 
> 00:02.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI-X Root Port
> [1002:5a34]
> 
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x5a3f, quirk_disable_msi);
> /* RS480 PCI bridge */

Yeah, apparently.

00:02.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI-X Root Port
[1002:5a34]

So, there are two broken PCI bridges.  Argh....  Okay, please try the
attached patch.  It includes both 5a34 and 5a3f.

Thanks for your patience.

-- 
tejun

--------------010905050707090900000006
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3411483..b0e89db 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1648,6 +1648,8 @@ static void __devinit quirk_disable_msi(
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x5a34, quirk_disable_msi); /* RS480 PCI-X root port */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x5a3f, quirk_disable_msi); /* RS480 PCI bridge */
 
 /* Go through the list of Hypertransport capabilities and
  * return 1 if a HT MSI capability is found and enabled */

--------------010905050707090900000006--

From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: About forcing 32bit DMA patch for AMD690G(SB600)
Date: Thu, 24 Jan 2008 11:53:24 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E501BF60F@sshaexmb1.amd.com>
References: <B90463BC30D2E446BA423D888DC85E501BF3CB@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:48530 "EHLO
	outbound6-va3-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752825AbYAXEF6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jan 2008 23:05:58 -0500
Content-class: urn:content-classes:message
In-Reply-To: <B90463BC30D2E446BA423D888DC85E501BF3CB@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, sriharivijayaraghavan@yahoo.com.au, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

Hi Jeff:

Do you have any suggestion on my plan to withdraw Tejun's forcing 32 bit
DMA patch?
As well as further validation to the 64 bit DMA capacity of SB600 SATA
controller?


Thanks
Best Regards
Shane


> -----Original Message-----
> From: Shane Huang
> Sent: Wednesday, January 23, 2008 3:44 PM
> To: sriharivijayaraghavan@yahoo.com.au; 'Tejun Heo'
> Cc: 'linux-ide@vger.kernel.org'; Shane Huang
> Subject: About forcing 32bit DMA patch for AMD690G(SB600)
> Importance: High
> 
> Resending this mail and adding linux-ide mail list...
> 
> 
> Quoting Tejun:
> > Uh-oh, wait a bit. Nope. Until we figure out what the something else
is
> > and positively verify 64bit DMA works fine, the quirk stays in.
> 
> Our HW engineer has confirmed that our SB600 SATA controller indeed
has
> some MSI issue, and we do not have any workaround.
> 
> The workaround "quirk_msi_intx_disable_bug" to SB700 SATA controller
> can NOT work to SB600 SATA controller in my debug, while disablement
to
> RS690 MSI in kernel source can fix it.
> 
> As to the SB600 64 bit DMA capacity, do you have any methods to do
further
> verification? I do NOT find any problem in my debug after I disabled
RS690
> MSI in kernel 2.6.24-rc7.
> 
> 
> 
> Thanks
> 
> Best Regards
> Shane
> 
> 
> -----Original Message-----
> From: Shane Huang
> Sent: Wednesday, January 23, 2008 2:56 PM
> To: sriharivijayaraghavan@yahoo.com.au
> Cc: 'Tejun Heo'; Shane Huang
> Subject: About forcing 32bit DMA patch for AMD690G(SB600)
> Importance: High
> 
> Hi Srihari:
> 
> This Shane @ AMD. I'm sorry to disturb you.
> 
> I find that there is one patch which forces SB600 use 32bit DMA:
>
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=c7a42156d99bcea7f8173ba7a6034bbaa2ecb77c
> 
> This patch was submitted by Tejun to fix one issue on your platform:
> http://marc.info/?l=linux-ide&m=117810966106759&w=2
> 
> But after a discussion with our hardware engineers, Tejun(the patch
author),
> and some debugging, we believe that that SB600 can support 64 bit DMA,
> the root cause should be something else, while disablement to RS690
MSI
> in kernel source can be the workaround.
> So, we are going withdraw Tejun's patch ASAP.
> 
> I wonder whether you still have that AMD690G platform or not?
> Are you able to help to do further confirmation before we withdraw it?
> 
> You can just download kernel 2.6.21.1(which was used when you reported
> the bug), apply the attached disable_RS690_MSI.patch, and build the
kernel.
> Please tell me if that patch can fix your issue without Tejun's patch.
> This patch has been proved to work on my RS690+SB600 under Fedora7
x86_64.
> 
> You can also try my another disable_MSI_and_withdraw_32bit.patch
> under linux kernel 2.6.24-rc7, to see whether this patch can fix your
> issue too. This method also can work on my RS690+SB600 platform.
> 
> 
> Thanks & waiting for your test result~~~ :-)
> 
> 
> Best Regards
> Shane




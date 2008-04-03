From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Thu, 03 Apr 2008 09:44:18 +0900
Message-ID: <47F42862.1030406@gmail.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <39B20DF628532344BC7A2692CB6AEE0702679018@orsmsx420.amr.corp.intel.com> <47D03272.9080209@garzik.org> <39B20DF628532344BC7A2692CB6AEE070283295C@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:59447 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758954AbYDCAoZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 20:44:25 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2881617wff.4
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2008 17:44:24 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE070283295C@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Gaston, Jason D wrote:
>> Gaston, Jason D wrote:
>>> If you disable the IDE Redirection in BIOS on that system, the 0x29b6
>>> controller should not appear.  If you are not using this, it would be
>>> interesting to see if this effects what you are seeing.
>>
>> I think its fair to say that a certain amount of Linux users will 
>> inevitably have this option enabled in their BIOS.  We should have a 
>> plan to deal with this sanely...?
> 
> I was able to add the IDER Contoller DeviceID to ata_generic.c and it
> seemed to work fine.  I was also able to add it to ata_piix.c as a SATA
> Controler and it seemed to work ok as well.  However, when I tried to
> add it to ata_piix.c as a PATA Controller if failed cable detection.  I
> guess this would be expected as it is a Virtual IDE contoller.
> 
> Where is the correct place to add support for IDE Redirection
> Contollers?

What's IDE redirection?  SATA appearing as IDE?

-- 
tejun

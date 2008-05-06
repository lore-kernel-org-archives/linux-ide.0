From: Johan van den Berg <johanvdb@teqcle.co.za>
Subject: Re: Initio 162x SATA controllers
Date: Tue, 6 May 2008 02:23:19 +0200
Message-ID: <0D15E6A9-C41F-413B-9D3F-B20342A62763@teqcle.co.za>
References: <B0DB428E-D75D-4E79-A749-B6E89C19E8E5@teqcle.co.za> <20080505223632.0b0b667b@core>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ctb-mesg-1-2.saix.net ([196.25.240.80]:39734 "EHLO
	ctb-mesg-1-2.saix.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195AbYEFAX2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 20:23:28 -0400
In-Reply-To: <20080505223632.0b0b667b@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Thanks Alan

I have pulled the latest git and can confirm (via some reading of the  
code) that I have the latest patches for the inic162x  as modified by  
Tejun Heo.

I have now compiled and installed 2.6.26-rc1.

My boot disk is also SATA though and connected via an onboard intel  
chip (00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA  
Controller (rev 02)) which requires the ata_piix driver.

On RHEL5 2.6.18 I am able to boot off ata_piix but not access the  
inic162x, and on 2.6.26-rc1 I am unable to access ata_piix hardware  
but inic162x seems to work.

The issue I am experiencing with ata_piix is identical to: http://www.nabble.com/-2.6.18,19--SATA-boot-problems-(ICH6-ICH6W)-td7799939.html

Any directions would be appreciated.


Johan van den Berg
Managing Director
Teqcle Information Technologies (Pty.) Ltd.

Email: johanvdb@teqcle.co.za
Cel: 0732013520




On 05 May 2008, at 11:36 PM, Alan Cox wrote:

>> I have read up as much as possible to start looking into hacking the
>> driver to support LBA48. Any pointers / suggestions before I start
>> bumping my head?
>
> Tejun committed an updated driver to the devel tree so if you pull the
> current git trees you should be able to get it to work.
>
> Alan


From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] 460EX on-chip SATA driver<kernel 2.6.33> < resubmission
 : 01>
Date: Wed, 17 Mar 2010 16:15:33 -0400
Message-ID: <4BA13865.4080408@pobox.com>
References: <1268646854-27387-1-git-send-email-rsarmah@appliedmicro.com> <AC311A8E81420D4EBC1F26E6479848FE065B7F30@SDCEXCHANGE01.ad.amcc.com> <201003171303.06258.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:52380 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab0CQUPg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2010 16:15:36 -0400
In-Reply-To: <201003171303.06258.sr@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Roese <sr@denx.de>, Rupjyoti Sarmah <rsarmah@amcc.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org, Rupjyoti Sarmah <rupjyoti.sarmah@gmail.com>, linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rupjyoti.sarmah@appliedmicro.com>, linux-kernel@vger.kernel.org

On 03/17/2010 08:03 AM, Stefan Roese wrote:
> Hi Rup,
>
> On Wednesday 17 March 2010 05:23:16 Rupjyoti Sarmah wrote:
>> This patch enables the on-chip DWC SATA controller of the AppliedMicro
>> processor 460EX.
>
> Apart from the other comments, did you take a look at the latest version of
> this driver in our linux-2.6-denx repository? We did some work on this driver
> for a new Canyonlands release last year. It's hard to check this for me now,
> with this line wrapped patch (the drivers diverged somewhat). So either check
> for yourself, or send a new, not line-wrapped, patch version so that I can
> better check myself.
>
> BTW: It would be nice if you would add me to Cc on DWC-SATA related patches,
> since I've been involved in the development at some time.

I will wait for Rupjyoti to check the linux-2.6-denx repo, and resend 
the patches without word wrapping.

	Jeff




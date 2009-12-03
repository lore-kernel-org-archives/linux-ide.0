From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 12:53:59 -0500
Message-ID: <4B17FB37.2030501@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <4B1771CD.3090409@garzik.org> <200912031339.14440.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756406AbZLCRx6@vger.kernel.org>
In-Reply-To: <200912031339.14440.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 12/03/2009 07:39 AM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 03 December 2009 09:07:41 am Jeff Garzik wrote:
>> The merge window is upon us, which by strict rules means that anything
>> not already in libata-dev.git#upstream needs to wait until 2.6.34.
>>
>> However, bug fixes and the like should definitely be in 2.6.33.
>> ->init_host is definitely 2.6.34 material.  Some of the other stuff
>> could go either way.

> If you would like to apply some of my patches to 2.6.33 you are more than
> welcome to do it.  I can even prepare separate git tree with specific changes
> to make it easier for you once you tell me which changes you would like to
> see in it.

OK, great.

Can you prepare a patchset containing only fixes?  Comment-only changes 
are acceptable too.  Trivial changes too, if they are extremely trivial :)

Include nothing that adds features, removes or unifies drivers, etc.

Please do it in standard kernel submit form, which is either
(a) repost the patches (yes, again) being submitted for 2.6.33, or
(b) a standard git pull request, which includes shortlog, diffstat, and 
all-in-one diff.

	Jeff

From: Roger Heflin <rheflin@atipa.com>
Subject: Re: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Date: Wed, 26 Apr 2006 09:52:11 -0500
Message-ID: <444F891B.3050808@atipa.com>
References: <8E8F647D7835334B985D069AE964A4F7011B260D@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:29705 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932463AbWDZOwS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Apr 2006 10:52:18 -0400
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7011B260D@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
> Is your OS installed either sda or sdb?
> 
> Because I get this type of message using a single disk... On which my FC5 stands...
> 
> I'll give it a try tonight and see if I can cause the problem manually but I doubt I'll be able to stop the system from hanging...  Unless my bug is not related.
> 
> - vin
> 
>

Vin,

Please don't top post, many will yell at you on this list for that.

OS is on sda, nothing is on sdb which is probably why I don't have the
behavior happening at unexpected times, sdb won't be used except for
during my test.

I believe I am seeing similar behavior on sata_mv controllers so
it might be a more basic problem in libata, and not related to the specific
sata_nv driver at all.

                                     Roger

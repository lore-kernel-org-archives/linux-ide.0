From: Tejun Heo <htejun@gmail.com>
Subject: Re: please add support for the VT8251
Date: Mon, 31 Jul 2006 06:17:41 +0900
Message-ID: <44CD21F5.2020909@gmail.com>
References: <20060730185251.GA6954@ns.raidoneeyaikaep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:4752 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932148AbWG3VRe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Jul 2006 17:17:34 -0400
Received: by py-out-1112.google.com with SMTP id t32so456713pyc
        for <linux-ide@vger.kernel.org>; Sun, 30 Jul 2006 14:17:34 -0700 (PDT)
In-Reply-To: <20060730185251.GA6954@ns.raidoneeyaikaep.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ronan <mr_platelet+m601@fastmail.fm>
Cc: linux-ide@vger.kernel.org

Ronan wrote:
> Hi.
> 
> I don't like to badger open-source developers, but an email from Jeff
> Garzik (archived at [1]) suggests that it may be worth doing so in my
> particular situation.
> 
>   [1] http://marc.theaimsgroup.com/?l=linux-ide&m=114290600200440&w=2
> 
> My situation is this: I recently purchased a PC which contains a VIA
> VT8251 southbridge.  As far as I can see, this is not currently supported
> by Linux, so it seems that (as I have insufficient knowledge to write
> the code myself) I have no option but to wait until it is.  Therefore,
> I would like to request that the Linux IDE developers implement support
> for this chipset.

Already went into mainline.  v2.6.18-rc3 already includes it.  If you're 
uncomfortable with -rc series, libata-tj-stable patch also has it.

http://home-tj.org/wiki/index.php/Libata-tj-stable
http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710.tar.bz2

-- 
tejun

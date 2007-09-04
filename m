From: Richard Scobie <richard@sauce.co.nz>
Subject: Re: MDADM restart at system boot time
Date: Wed, 05 Sep 2007 10:47:50 +1200
Message-ID: <46DDE096.5030904@sauce.co.nz>
References: <8f2c1194b4839dee2ea49eedfeaf783a@7digital.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:35029 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbXIDWne (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Sep 2007 18:43:34 -0400
Received: from [192.168.4.111] (unknown [192.168.4.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp22.sauce.co.nz (Postfix) with ESMTP id 0DE43288263
	for <linux-ide@vger.kernel.org>; Wed,  5 Sep 2007 10:43:32 +1200 (NZST)
In-Reply-To: <8f2c1194b4839dee2ea49eedfeaf783a@7digital.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Paul wrote:
> Hi,
>  
> I hope someone can help.
>  
> I have manually installed mdadm and now have a working array. I installed mdadm from the tarball, then did 'make install'
>  
> My problem is after system reboot the array will not start as the daemon is not running, I guess.
>  
> In order to access my files I have to re-create the array, which it complains about and then re-mount the disks, via the usual 'mount /dev/md0 /data', I know this 'mount' can be done via fstab, but I need the first part to work first.
>  
> I have the following info in my mdadm.conf file:
> 
> DEVICE /dev/hdb1 /dev/hdc1
> ARRAY /dev/md0 level=raid1 num-devices=2 UUID=0f0e3d1f:52580ad4:2ef6a2e7:f760e130
>         devices=/dev/hdb1,/dev/hdc1

Apologies, I was slightly incorrect on the last part.

Replace the "DEVICE" entry with:

DEVICE partitions

and add

auto=part

in place of the "devices=/dev/hdb1,/dev/hdc1" section at
the end of your ARRAY entry.


Regards,

Richard


From: Tejun Heo <htejun@gmail.com>
Subject: Re: JMicron JMB363 issue fixed / ICH8 RAID volume trace
Date: Fri, 25 May 2007 12:10:57 +0200
Message-ID: <4656B631.8060305@gmail.com>
References: <76366b180705231843i19f88582xaf22ba0d58313feb@mail.gmail.com>	 <46555F7C.4000804@gmail.com> <76366b180705241827u2228101eyf8c8b7aa62c594df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:43673 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbXEYKLK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 06:11:10 -0400
Received: by py-out-1112.google.com with SMTP id a73so1307501pye
        for <linux-ide@vger.kernel.org>; Fri, 25 May 2007 03:11:09 -0700 (PDT)
In-Reply-To: <76366b180705241827u2228101eyf8c8b7aa62c594df@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: "ethanhsiao@jmicron.com" <ethanhsiao@jmicron.com>, linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> Tejun, fdisk -l output is attached
> 
> Basically, in the ICH8 BIOS:
> /dev/sda + sdb = 2 500GB drives in RAID1 configuration
> /dev/sdc + sdd + sde + sdf = 4 320GB drives in RAID5 configuration
> 
> /dev/sdg is a 320GB boot drive connected to the JMB363 chipset
> 
> Is there some kind of problem when probing these partitions because
> they are fake software RAID through the ICH8? The messages only spew
> at boot time.

OIC, you need to use dm-raid to use those fake RAIDs properly.  If you
don't intend to access the RAIDs, you don't need to care.

-- 
tejun

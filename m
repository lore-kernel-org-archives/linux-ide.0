From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: improve initialization and legacy handling,
 take#3
Date: Thu, 10 Aug 2006 20:32:35 +0900
Message-ID: <44DB1953.3060803@gmail.com>
References: <11551977882917-git-send-email-htejun@gmail.com> <44DB101F.2080505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:27063 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161166AbWHJLcl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 07:32:41 -0400
Received: by nz-out-0102.google.com with SMTP id n1so137140nzf
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 04:32:41 -0700 (PDT)
In-Reply-To: <44DB101F.2080505@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hello, all.
>>
>> This is the third take of improve-init-and-legacy patchset.  This
>> patchset contains patches from Jeff Garzik, Alan Cox and me to
>> fix/clean up initializaton and legacy handling.  Changes from the last
>> take[L] are
>>
>> * adapted to Brian King's sas port alloc/init stuff (new patch added
>>   #01-update-ata_host_init-and-rename-it-to-ata_port_init_shost)
>>
>> * fix-new-legacy-handling patch merged into rework-legacy-handling as
>>   Jeff suggested.
>>
>> This patchset is against
>>
>>   libata-dev#upstream [U]
>> This patchset is available in the following git tree.
>>
>>   http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream
>>   git://htj.dyndns.org/libata-tj tj-upstream
> 
> pulled
> 
> 
>> PATA drivers have been updated accordingly and available at (properly
>> merged)
>>
>>   http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-pata-drivers
>>   git://htj.dyndns.org/libata-tj tj-pata-drivers
> 
> pulled
> 
> 
>> Updated ALL branch is available at
>>
>>   http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-ALL
>>   git://htj.dyndns.org/libata-tj tj-ALL
> 
> FWIW, I usually just update this manually.  The process I used for this 
> email's pulls was
> 
> cd /spare/repo/libata-dev
> git checkout upstream
> git pull $url tj-upstream
> git checkout pata-drivers
> git pull . upstream
> git pull $url tj-pata-drivers
> git checkout ALL
> git pull . pata-drivers
> 
> Thus, changes are pulled from upstream to downstream branches.

I see.  For this patchset though, pulling pata-drivers that way would 
give it a small window of commits (probably just one) where pata drivers 
won't build properly.  tj-pata-drivers was built by...

1. pulling #tj-upstream before removing old legacy handling
2. updating #tj-pata-drivers to use new legacy handling
3. killing old legacy handling in #tj-upstream
4. pulling again

Such that pata-drivers doesn't fail to build after upstream merge.  I 
won't make ALL branch from now on and tell you if merge needs some 
special ordering.

Thanks.

-- 
tejun

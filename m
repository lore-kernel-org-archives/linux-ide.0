Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C387CA6F;
	Thu, 19 Feb 2026 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771465116; cv=none; b=Tvg8crh916log+rYnNf8MqokSxj1Ivg3F0sz+T00sXzhXIkVCyKtvvLsEpdt1XkPdiAluSj4iQdrAWSzuW2PtHp0c8M75kUqNOkvv8nogFtey+e9DV9wcjeMTxk62efXlErBlgaaaYJMy/goZZSARU9LYrb/Q/mUDrkU7nJ3MRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771465116; c=relaxed/simple;
	bh=0eLuBTDqPctu+4vbIg6FzRU6nHHXVxKUVCW3TGEggfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUa2+GWLbjlJsdOho5sjrOYmnJY94Iv0+qncwWr30ERgIlvhXFaYJ8YQ++fOCkNSs673kESelV7FdBreLle8ekhOfX67uDorfKId+EIvDRT8R6N2nLa3twdydtL063fG7QHjsTIEzINZZF1B3JmnKsHNgO0pvrJdwppmdSeqVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyHZtKA0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyHZtKA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF79C116D0;
	Thu, 19 Feb 2026 01:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771465116;
	bh=0eLuBTDqPctu+4vbIg6FzRU6nHHXVxKUVCW3TGEggfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SyHZtKA0F7QKxZNRtBTylkK0I5JP65gi+CAs/td7PHI7nayopt+05rDJODPufFr/d
	 R5Don5ik1pXb14VN6juCitrSzmBpZktM1uo0L2HWKQJrNTT3VO36PaKLR6qDJDUmap
	 TP7g+VErpaeYQCBLkxzufScsOcQuYPjMEbr3AGr93NZax3dgaiyWjgZSGK/XrhCKbL
	 ou08B/R9jnAoERMaIB7QXrGyr6nDJw5qPDhfcXmOjELpsAiPLIuGLyrJxt1EooTW3H
	 kKHLDrsbJGtWCGfX8Kcez6zAIYcLJSLPWmhyKsZ1Y/k7zn0Anky5i9QRjYWWTVQWsP
	 r8xdfp+z6zQcw==
Message-ID: <1e4e903b-143f-4f95-a41d-2a87cdcaf2c4@kernel.org>
Date: Thu, 19 Feb 2026 10:33:22 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ide?] UBSAN: shift-out-of-bounds in ata_qc_issue
To: Niklas Cassel <cassel@kernel.org>,
 syzbot <syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6994d5c7.a70a0220.2c38d7.010b.GAE@google.com>
 <aZWKRkTVIJuLS_Y7@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aZWKRkTVIJuLS_Y7@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/26 6:45 PM, Niklas Cassel wrote:
> On Tue, Feb 17, 2026 at 12:55:35PM -0800, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    ca4ee40bf13d Partly revert "drm/hyperv: Remove reference t..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13c6c722580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a771bfd268751cd6
>> dashboard link: https://syzkaller.appspot.com/bug?extid=1f77b8ca15336fff21ff
>> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ca4ee40b.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/c714adf37ddd/vmlinux-ca4ee40b.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/4d56cd9f6175/bzImage-ca4ee40b.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
>> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
> 
> 4210818301 is 0xfafbfcfd
> 
> 0xfafbfcfd is ATA_TAG_POISON.
> 
> ATA_TAG_POISON is set by ata_qc_free(), so it appears that
> ata_scsi_deferred_qc_work() is trying to issue a QC that has
> already been freed.

I checked the code but I fail to see any path that can lead to this happening.
I did more tests using qemu q35 machine as used by syzbot, and everything looks
fine. So not sure what is happening here. I will dig further.

-- 
Damien Le Moal
Western Digital Research

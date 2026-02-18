Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37C318B99;
	Wed, 18 Feb 2026 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407947; cv=none; b=jO3RHme29PawF649Wh3WBn6hRAUqwoxXbtn0S+8TxQzJDVwCnDCX0ID88Wq8yjCFIwjevrHD1/1Q4jdhvmRpJyust19bZJHOJ3uGRyb8gKwnPzrMTQ/dxswsA8+E3GNQeK9RFiQvTXb4AASJntZECKmnO5aNluPqOuWWhpb4ytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407947; c=relaxed/simple;
	bh=yntYa+iljLttU0MXn0A1t1H14+JZONZwUeGoSafEVNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQLgymw3GUY+eNY3fQotLqwMfpQ3T1tZ6XQiUZWteUEZ8b/j+ktGVoBhrufBYDfajgtbCs8TdIVKOf64pz10COxlXhBl8ZXZ3SRw10go+Hk89L2GwKVlB1cssjIE9wkWx43E/M9PAMVN/dYLewWEZh7vdXXj3RJbhm8eTiOKH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr/2mNyb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr/2mNyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AA8C19421;
	Wed, 18 Feb 2026 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771407946;
	bh=yntYa+iljLttU0MXn0A1t1H14+JZONZwUeGoSafEVNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gr/2mNybYfweiu4Nf0eADd8SZPknIhx/iPE5tDjZLsAE0gKg8Cd3MkSC+mBQSto29
	 bthCGF+oonKjse7KUt/nMVgTf61hQLX7L3cQyM3/5nEXokggCH3tkTbaiJBGS9e8KB
	 xT7CxugBGtgd+/8amgGf3tCu9ipsN+kg/0ohdxQkb7uUcHBEL30C/FAQpPOqM0xWCx
	 fLmYdmADDInRwp7wIBeBQ2/5m+Q5T2PhiIM7iEdzLB4Lc+HTXwpQ8icysprLRL7J3W
	 +Nwl9VuONoQuCdBwwK8MXlHEfkG7HgQ5zS40s6zFh1iVfWW3Myy2NhXj0HaSHzqgHx
	 /j/j5TpYHHrYA==
Date: Wed, 18 Feb 2026 10:45:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: syzbot <syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ide?] UBSAN: shift-out-of-bounds in ata_qc_issue
Message-ID: <aZWKRkTVIJuLS_Y7@ryzen>
References: <6994d5c7.a70a0220.2c38d7.010b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6994d5c7.a70a0220.2c38d7.010b.GAE@google.com>

On Tue, Feb 17, 2026 at 12:55:35PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ca4ee40bf13d Partly revert "drm/hyperv: Remove reference t..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c6c722580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a771bfd268751cd6
> dashboard link: https://syzkaller.appspot.com/bug?extid=1f77b8ca15336fff21ff
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ca4ee40b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c714adf37ddd/vmlinux-ca4ee40b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4d56cd9f6175/bzImage-ca4ee40b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'

4210818301 is 0xfafbfcfd

0xfafbfcfd is ATA_TAG_POISON.

ATA_TAG_POISON is set by ata_qc_free(), so it appears that
ata_scsi_deferred_qc_work() is trying to issue a QC that has
already been freed.


Kind regards,
Niklas

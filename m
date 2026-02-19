Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776132ABC3;
	Thu, 19 Feb 2026 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541081; cv=none; b=Tzx8FupZLsaJzcu//jRd0gn06xJ1wkd9qo7CYrhs1VjQ7XXM2g07Fjk7PKN9z/+lQX8MTPMM5VizqHBg9T/zVxfKPHYT74MNPttznXJX6A7JXZUn8DoSiap2G2i0Ri8iyyeiU9tBnrerLgmt61YIkx0TD6FlPZkhLTSkurS/5Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541081; c=relaxed/simple;
	bh=0v/TL+VaBEJvXqvoBtfSIHg95q9Z7AbaCChRGg5+qdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdVOLC4QTa9c1w+KR0jx51KDR84+On1Gy/svfqaQWwjVN4IK7Uo4ZeDqZMyU7Xw2ZjxjaoFDv1ZsT7H/NbNus7K/8z4FjPI19crqJpKHXQwSdLfmrTV0M01Ob7HWMTXVFkCRvBx7MMii1/wLggb1YAqiJB+v75isHcL5dLc1ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVlJzjOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVlJzjOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D46C4CEF7;
	Thu, 19 Feb 2026 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771541080;
	bh=0v/TL+VaBEJvXqvoBtfSIHg95q9Z7AbaCChRGg5+qdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVlJzjOCxzqPyPB7N1uYlG6Dh4gcUdyz0aTqH62tTOdcu/WKCA/gbHCXzMz0Ya2ZC
	 6e3AqYK5cLJUhp3oVw7IGPD8RBB94Q+M/CMbZ2Zbq6tSFxuEuEMOSnhOXM0p/WpsWC
	 Nu5lSFlwcQ2XC+1Y8fd4B5irnR62VJWhnAoznYwa/REx8L8rD0uGR6C/tWYJe4+RrC
	 sr8eKygo4E2THe5/Wy2U4I1y9o52F7APy78C6L8TqfpsAFZtqODW/cdqXFKLYcXnJS
	 UMliP8hl1M61se/ENAXRQBZ//wGNIH7QImc02daa7PYVSlzOEivN6684IwC6mWgLwM
	 AZ8+IZjkRr6kQ==
Date: Thu, 19 Feb 2026 23:44:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: syzbot <syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com>,
	syzkaller@googlegroups.com
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ide?] UBSAN: shift-out-of-bounds in ata_qc_issue
Message-ID: <aZeRycd4R-xG9Z3p@ryzen>
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

Hello syzkaller folks,

We syzkaller seems to have found a bug that it can reproduce very easily.

Looking at the dashboard for this bug:
https://syzkaller.appspot.com/bug?extid=1f77b8ca15336fff21ff

It has so far been reproduced 4 times in 3 days.

However, there is no reproducer yet.

Any advice on how we can try to trigger this without an exact reproducer
available yet?


Kind regards,
Niklas


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

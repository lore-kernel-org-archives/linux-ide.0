From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Silent corruption on AMD64
Date: Sat, 31 Mar 2007 19:52:36 -0700
Message-ID: <20070331195236.7c818ed5.akpm@linux-foundation.org>
References: <20070401012736.GT15189@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:45927 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbXDACwh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Mar 2007 22:52:37 -0400
In-Reply-To: <20070401012736.GT15189@vitelus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> On Sat, 31 Mar 2007 18:27:36 -0700 Aaron Lehmann <aaronl@vitelus.com> wrote:
> I have spent a lot of time trying to find a simpler test case. So far,
> as far as I can tell, there are three conditions that must be
> satisfied for corruption to occur:
> 
> 1. Heavy Ethernet load (nc remotehost < /dev/zero)
> 2. Heavy disk write load on any non-sata_sil drive (cat /dev/zero > /path)
> 3. Heavy disk read load on any other drive (tar c /path | cat > /dev/null)
> 
> With these conditions satisfied, data read off sda or sdb (the drives
> associated with sata_sil) is often corrupted. Since I can only see
> this problem with files on those two drives, I'm inclined to suspect
> the sata_sil driver, but I really have no idea what's going on. I know
> this is not a recent issue - I experienced very similar corruption at
> least a year ago. I wasn't able to reproduce it at the time, because
> it only appeared in the backups I was restoring from.

Are you able to provide us with some before-and-after data so we
can see this corruption.

See, if it's dropped-bits or shifted-data or eight-byte-aligned
kernel addresses or whatever, that helps us generate theories..

From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Do not send RW commands to locked disks.
Date: Thu, 03 Sep 2009 08:03:02 +0900
Message-ID: <4A9EF9A6.7030404@kernel.org>
References: <1251851285-9159-1-git-send-email-gwendal@google.com>	 <4A9DCCC6.6040102@kernel.org> <e7510f760909021443m26bee6b9y660f0c5fad89c705@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39612 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684AbZIBXDF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Sep 2009 19:03:05 -0400
In-Reply-To: <e7510f760909021443m26bee6b9y660f0c5fad89c705@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org

Hello, Gwendal.

Gwendal Grignou wrote:
> You have a point, but setting the flag LOCKED when an error happen
> will mean that a braindead device [which always trigger
> ata_id_locked()] will work until an internal disk error happens; that
> will make debugging difficult.

Yeah, right, unrelated error can set the LOCKED bit.  Maybe we can
devise something intelligent there.  A simple state machine to detect
those conditions?

> Instead, I am working on adding the provision for a blacklist to allow
> bad devices to bypass the test.

Blacklist wouldn't be too bad too but I really think we shouldn't be
believing the identify data at the face value.  What if the device
sets the bit after security_lock but fails to fail commands which
wouldn't be all that surprising given the general quality of ATA
devices which has been diving rapidly with all those new vendors
jumping onto the SDD wagon?  So, I think it should still be something
recognized and verified by EH before applying.

Thanks.

-- 
tejun

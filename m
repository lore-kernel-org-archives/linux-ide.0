From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [Bug 47781] ata2: exception Emask 0x10 SAct 0x0 SErr 0x4050002
 action 0xe frozen
Date: Mon, 24 Sep 2012 09:38:52 +0400
Message-ID: <1348465132.2467.0.camel@dabdike>
References: <bug-47781-11613@https.bugzilla.kernel.org/>
	 <20120923210732.7A31711FB4B@bugzilla.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35459 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792Ab2IXFi5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2012 01:38:57 -0400
In-Reply-To: <20120923210732.7A31711FB4B@bugzilla.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-ide <linux-ide@vger.kernel.org>

On Sun, 2012-09-23 at 21:07 +0000, bugzilla-daemon@bugzilla.kernel.org
wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=47781
> 
> 
> Alan <alan@lxorguk.ukuu.org.uk> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>           Component|IDE                         |SCSI
>          AssignedTo|io_ide@kernel-bugs.osdl.org |linux-scsi@vger.kernel.org

I'm a bit mystified by this reassignment.  This looks like a pure ata
problem to me; what makes you think it's SCSI?

James



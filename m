From: Andy Warner <andyw@pobox.com>
Subject: Re: Hot Plug and LIBATA
Date: Fri, 5 Nov 2004 11:38:53 -0600
Message-ID: <20041105113853.C27906@florence.linkmargin.com>
References: <02ba01c4c35b$f9f9bb70$4500a8c0@MarkK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:46788 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262734AbUKERkh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:40:37 -0500
Content-Disposition: inline
In-Reply-To: <02ba01c4c35b$f9f9bb70$4500a8c0@MarkK>; from mark.k@computer-design.co.uk on Fri, Nov 05, 2004 at 05:22:06PM +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Klarzynski <mark.k@computer-design.co.uk>
Cc: linux-ide@vger.kernel.org

Mark Klarzynski wrote:
> [...]
> I am presuming (and it is only a presumption) that LIBATA somehow cannot
> rescan the sata bus. does anybody know of a workaround / fix /
> suggestion or decent outlet for a tranquilizer?

Hotplug and libata don't play nicely together, yet.

I am working on this, and I expect others are doing
stuff too. Doing anything actually useful is fairly
intrusive to the structure and flow of the existing
code. Another problem you'd hit is the SCSI layer
trying to sync a recently departed drive :)

I don't have a timetable for my work. There are still
two things that have got pushed on the stack ahead of
hotplug. Neither of these is anywhere near as large
or complex as hotplug, thankfully.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634

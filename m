From: Jes Sorensen <jes@sgi.com>
Subject: Re: [patch] Fix DMA timeouts with sgiioc4
Date: Thu, 02 Feb 2006 09:45:09 +0100
Message-ID: <43E1C695.1080102@sgi.com>
References: <yq0vevzpi8r.fsf@jaguar.mkp.net> <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com> <20060201104913.GA152005@sgi.com> <58cb370e0602010308o4cde24aeg8d629b1b3d45cdd3@mail.gmail.com> <20060201111754.GB152005@sgi.com> <58cb370e0602010326k265ef278k4010df13fb5adf8c@mail.gmail.com> <20060201113607.GF152005@sgi.com> <58cb370e0602010444m46a39705q4a3043778df1628d@mail.gmail.com> <20060202080046.GB157213@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:10124 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423383AbWBBIpc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Feb 2006 03:45:32 -0500
In-Reply-To: <20060202080046.GB157213@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeremy Higdon wrote:
> Thanks Bartlomiej.  You're correct in that it is ATAPI only (and
> read-only also).
> 
> In this case, this is the final patch (last night's with a copyright
> update and removing spurious whitespace at end of line).

Hi Jeremy,

Just ack'ing for completeness! Please discard my previous patch and use
this one instead.

Cheers,
Jes

> 
> jeremy
> 
> Signed-off-by: Jeremy Higdon <jeremy@sgi.com>
Acked-by: Jes Sorensen <jes@sgi.com>

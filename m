From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sata_mv: fix loop with last port
Date: Fri, 8 Feb 2008 13:45:01 -0800
Message-ID: <20080208134501.4222995e.akpm@linux-foundation.org>
References: <200802071506.17459.yinghai.lu@sun.com>
	<47ABDAF2.7030209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757747AbYBHVqm@vger.kernel.org>
In-Reply-To: <47ABDAF2.7030209@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Yinghai.Lu@Sun.COM, jgarzik@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, saeed@marvell.com
List-Id: linux-ide@vger.kernel.org

On Thu, 07 Feb 2008 23:30:42 -0500
Mark Lord <liml@rtr.ca> wrote:

> > Signed-off-by: Yinghai Lu <yinghai.lu@sun.com>
> ..
> 
> Yup, obvious bug fixes, thanks.
> Signed-off-by: Mark Lord <mlord@pobox.com>

Typically we'll use Acked-by: here.  Because Signed-off-by: implies that
you were in the delivery path, or that you worked on the patch.  afacit
that is not the case.  Documentation/SubmittingPatches has some explanation.

I made that change to my copy of the patch - please let me know if that
was incorrect, thanks.

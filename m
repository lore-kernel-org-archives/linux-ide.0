From: Jens Axboe <axboe-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Re: HDAPS, Need to park the head for real
Date: Fri, 26 Aug 2005 08:49:35 +0200
Message-ID: <20050826064934.GP4018@suse.de>
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de> <430CEA54.7060803@dresco.co.uk> <1124967468.21456.6.camel@localhost.localdomain> <430E0A84.8080809@dresco.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <hdaps-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <430E0A84.8080809-Xbpc2PeERmvQXOPxS62xeg@public.gmane.org>
Sender: hdaps-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: hdaps-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/hdaps-devel>,
	<mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:hdaps-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/hdaps-devel>,
	<mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=hdaps-devel>
To: Jon Escombe <lists-Xbpc2PeERmvQXOPxS62xeg@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Alejandro Bonilla Beeche <abonilla-N/cRWR3FREN3ZuITGxAgx9i2O/JbrIOy@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, hdaps devel <hdaps-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 25 2005, Jon Escombe wrote:
> Alan Cox wrote:
> >@@ -1661,6 +1671,9 @@
> >                where = ELEVATOR_INSERT_FRONT;
> >                rq->flags |= REQ_PREEMPT;
> >        }
> >+       if (action == ide_next)
> >+               where = ELEVATOR_INSERT_FRONT;
> >+
> >        __elv_add_request(drive->queue, rq, where, 0);
> >        ide_do_request(hwgroup, IDE_NO_IRQ);
> >        spin_unlock_irqrestore(&ide_lock, flags);
> >
> >Also puzzles me- why is this needed ?
> 
> I wanted the park command to get in at the head of the queue (behind the 
> currently executing request).
> 
> Contrary to the comments for ide_do_drive_cmd(), ide_next didn't appear 
> to do anything to achieve this? At least from my initial testing before 
> I made this change - it could take a second or so for the park command 
> to be issued if the disk was busy....

That part seems to have been lost, apparently. The above patch is
correct.

-- 
Jens Axboe



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

From: <Stuart_Hayes@Dell.com>
Subject: ide-cd question
Date: Thu, 3 Feb 2005 14:34:42 -0600
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EE861@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:25788 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S263602AbVBCUer convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 15:34:47 -0500
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Why does ide-cd use "DRIVER(drive)->end_request()" instead of
"cdrom_end_request()" in the function ide_cdrom_error when it wants to
end a request that's exceeded ERROR_MAX errors?  (See code below.)

With certain requests (GET_CONFIGURATION (0x46), in particular),
DRIVER(drive)->end_request() is not actually ending the request, because
rq->bio is not NULL--but it also is not clearing rq->errors, so this
request ends up getting retried forever, but no more resets are
attempted because rq->errors has exceeded ERROR_MAX.

Cdrom_end_request(), on the other hand, WILL end the request.

Thanks,
Stuart


	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr))
{
		/* other bits are useless when BUSY */
		rq->errors |= ERROR_RESET;
	} else {
		/* add decoding error stuff */
	}
	if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
		/* force an abort */
		HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
	if (rq->errors >= ERROR_MAX) {
		DRIVER(drive)->end_request(drive, 0, 0);  <--- should
this be cdrom_end_requeset()?
	} else {
		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
			++rq->errors;
			return ide_do_reset(drive);
		}
		++rq->errors;
	}

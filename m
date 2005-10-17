From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm ATA Security Options return errors
Date: Mon, 17 Oct 2005 16:31:50 -0400
Message-ID: <43540A36.2080404@rtr.ca>
References: <S1750797AbVJQQjQ/20051017163916Z+71@vger.kernel.org> <4353DBF1.1060001@gmx.de> <4353E257.5060104@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:49598 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932089AbVJQUbv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Oct 2005 16:31:51 -0400
In-Reply-To: <4353E257.5060104@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: t.schorpp@gmx.de
Cc: linux-ide@vger.kernel.org

I think the entire set of ATA security patches that were
sent to me for hdparm are bogus -- I lack the setup here
to try them, but another kind person is preparing patches
for hdparm to fix them.

Along the way, he has also discovered bugs in the ATA_TASKFILE
ioctls, but we have yet to work out a good description/patch
for the broken bits there.

Cheers

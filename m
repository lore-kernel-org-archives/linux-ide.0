From: Dennis Bijwaard <bijwaard@home.nl>
Subject: Re: 2.6.0test10 hangs just after IDE detection => aic7xxx hang
Date: Thu, 27 Nov 2003 19:57:55 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031127185755.GA1931@bijwaard.dyns.net>
References: <20031126215448.GA1801@bijwaard.dyns.net> <200311262311.48092.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cc76797-a.ensch1.ov.home.nl ([213.51.205.160]:2944 "EHLO
	jumbo.gronausestraat") by vger.kernel.org with ESMTP
	id S264577AbTK0S6J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Nov 2003 13:58:09 -0500
Content-Disposition: inline
In-Reply-To: <200311262311.48092.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Dennis Bijwaard <bijwaard@home.nl>, linux-ide@vger.kernel.org

Hi Bart,

* Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> [031126 23:13]:
> IDE related changes in 2.6.0-test10 are:
> ide-tape fixes, alim15x3 fix, AMD and nVidia update and TCQ disable.
> 
> If you are using aic7xxx SCSI you should try -test11 first (fixes hang).

Thanks, that was it!
-- 
Kind regards,
            Dennis

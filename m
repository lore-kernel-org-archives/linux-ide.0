From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Put the new API functions in the header files
Date: Fri, 05 Nov 2004 23:36:35 +0000
Message-ID: <1099697793.5567.85.camel@localhost.localdomain>
References: <1099672368.5630.47.camel@localhost.localdomain>
	 <200411052302.50280.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:37061 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261288AbUKFAj1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:39:27 -0500
In-Reply-To: <200411052302.50280.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Gwe, 2004-11-05 at 22:02, Bartlomiej Zolnierkiewicz wrote:
> * there is no ordering of your patches
> * they are splitted on file boundary not change boundary
>   (ie. appling one patch leaves you with kernel which won't compile)

Well I could send you bigger pieces if you want but you objected to that
last time.

> * they are whitespace damaged as usual

Well if you want to be a bigot about the old trailing space caused by
editor auto indenting feel free 8)



From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Mon, 10 Aug 2009 00:27:01 +0200
Message-ID: <200908100027.01469.bzolnier@gmail.com>
References: <h5kn9c$51r$1@ger.gmane.org> <h5krje$ec7$1@ger.gmane.org> <20090809175840.0705f2d0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50762 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbZHIW1h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 18:27:37 -0400
Received: by bwz19 with SMTP id 19so2303472bwz.37
        for <linux-ide@vger.kernel.org>; Sun, 09 Aug 2009 15:27:37 -0700 (PDT)
In-Reply-To: <20090809175840.0705f2d0@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jim Duda <jim@duda.tzo.com>, linux-ide@vger.kernel.org

On Sunday 09 August 2009 18:58:40 Alan Cox wrote:

> did before the old IDE people broke ide-scsi support.

ide-scsi was an orphan without a single person willing to work on it
or trying to fix outstanding problems (which didn't surprise me given
that you had to be IDE+SCSI+ide-scsi+st+sr expert to do it).

That was not the case with ide-tape (which is at least fixable because
it is now mere 2000 LOC and contains no inter-subsystem dependencies).

If you miss ide-scsi so much I don't quite understand what stops you
from bringing it back to live and stepping in as its Maintainer? :-)

The truth is that the change was ACK-ed by everybody except you and you
refused to step in as ide-scsi Maintainer..  so please stop defaming
hard working people (in this case Fujita and Borislav) and pushing some
childish views on what other people should be doing (without putting
absolutely no work into it yourself).

Thanks.

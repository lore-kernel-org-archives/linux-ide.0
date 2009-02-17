From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/10] ide: flags query macros
Date: Tue, 17 Feb 2009 15:33:28 +0100
Message-ID: <200902171533.29135.bzolnier@gmail.com>
References: <1234699692-9452-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:53738 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZBQPJm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Feb 2009 10:09:42 -0500
In-Reply-To: <1234699692-9452-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 15 February 2009, Borislav Petkov wrote:
> Hi,
> 
> this series adds the drive->atapi_flags and drive->dev_flags macro wrappers
> we discussed. The idea was to make the code more readable and this has
> been my main concern when coming up with the macro naming, therefore
> some macro names appear a tad more descriptive than the flag itself.
> 
>  drivers/ide/cmd640.c           |    2 +-
>  drivers/ide/ht6560b.c          |    3 +-
>  drivers/ide/ide-atapi.c        |   15 ++++++-------
>  drivers/ide/ide-cd.c           |   44 ++++++++++++++++++++-------------------
>  drivers/ide/ide-cd_ioctl.c     |   18 +++++++---------
>  drivers/ide/ide-devsets.c      |    8 ++----
>  drivers/ide/ide-disk.c         |   32 ++++++++++++++--------------
>  drivers/ide/ide-disk_proc.c    |    2 +-
>  drivers/ide/ide-dma.c          |    3 +-
>  drivers/ide/ide-eh.c           |   17 +++++++--------
>  drivers/ide/ide-floppy.c       |    6 ++--
>  drivers/ide/ide-floppy_ioctl.c |    2 +-
>  drivers/ide/ide-gd.c           |   14 ++++++------
>  drivers/ide/ide-io.c           |    9 +++----
>  drivers/ide/ide-ioctls.c       |    6 ++--
>  drivers/ide/ide-iops.c         |    6 ++--
>  drivers/ide/ide-lib.c          |    2 +-
>  drivers/ide/ide-park.c         |   11 ++++-----
>  drivers/ide/ide-pm.c           |    2 +-
>  drivers/ide/ide-probe.c        |   36 +++++++++++++++++---------------
>  drivers/ide/ide-proc.c         |    2 +-
>  drivers/ide/ide-tape.c         |   12 +++++-----
>  drivers/ide/ide-taskfile.c     |   16 +++++---------
>  drivers/ide/ns87415.c          |    5 +--
>  drivers/ide/pdc202xx_old.c     |    4 +-
>  drivers/ide/sc1200.c           |    2 +-
>  drivers/ide/trm290.c           |    4 +-
>  27 files changed, 136 insertions(+), 147 deletions(-)

One more thing I forgot yesterday:

Since it is not a lot of modified lines and the change is rather
straightforward it could as well be done in a single patch...

Thanks,
Bart

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 23/29] ide: map ide_task_ioctl() to ide_taskfile_ioctl()
Date: Thu, 3 Feb 2005 18:38:19 +0100
Message-ID: <58cb370e050203093868e1ed76@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202030813.GH1187@htj.dyndns.org>
	 <58cb370e050203093726c7cf70@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <58cb370e050203093726c7cf70@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 3 Feb 2005 18:37:04 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:

> as HDIO_DRIVE_TASKFILE only supports no-data protocol
> it should be easy to add missing bits here and get rid of calling
> ide_taskfile_ioctl()

stupid typo: s/HDIO_DRIVE_TASKFILE/HDIO_DRIVE_TASK/

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 29/29] ide: make data_phase explicit in NO_DATA cases
Date: Thu, 3 Feb 2005 18:43:07 +0100
Message-ID: <58cb370e050203094326ddfce8@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202031238.GN1187@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050202031238.GN1187@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 12:12:38 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 29_ide_explicit_TASKFILE_NO_DATA.patch
> >
> >       Make data_phase explicit in NO_DATA cases.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>
> 
> Index: linux-ide-export/drivers/ide/ide-disk.c
> ===================================================================
> --- linux-ide-export.orig/drivers/ide/ide-disk.c        2005-02-02 10:28:07.852771465 +0900
> +++ linux-ide-export/drivers/ide/ide-disk.c     2005-02-02 10:28:08.121727827 +0900
> @@ -300,6 +300,7 @@ static unsigned long idedisk_read_native
>         args.tfRegister[IDE_SELECT_OFFSET]      = 0x40;
>         args.tfRegister[IDE_COMMAND_OFFSET]     = WIN_READ_NATIVE_MAX;
>         args.command_type                       = IDE_DRIVE_TASK_NO_DATA;
> +       args.data_phase                         = TASKFILE_NO_DATA;
>         args.handler                            = &task_no_data_intr;

Could you add small helper to ide.h for doing this?

static inline void ide_prep_no_data_cmd(ide_task_t *task)
{
        task->command_type = IDE_DRIVE_TASK_NO_DATA;
        task->data_phase      = TASKFILE_NO_DATA;
        task->handler            = &task_no_data_intr;
}

Also please move this patch earlier in the series
so I can merge it quickly.

Thanks.

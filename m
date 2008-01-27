From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 07/32] ide-tape: refactor the debug logging facility
Date: Sun, 27 Jan 2008 17:12:47 +0100
Message-ID: <200801271712.48082.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:32581 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502AbYA0TcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:17 -0500
Received: by fk-out-0910.google.com with SMTP id z23so893143fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:16 -0800 (PST)
In-Reply-To: <1201427300-3954-2-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
>=20
> Teach the debug logging macro to differentiate different log levels b=
ased on the
> type of debug level enabled specifically instead of a threshold-based=
 one.
> Thus, convert tape->debug_level to a bitmask that is written to over =
/proc.

This warrants rename of the setting from "debug_level" to "debug_mask".

> Also,
> - Cleanup and simplify debug macro thus removing a lot of code lines,
> - Get rid of unused debug levels,
> - Adjust the loglevel at several places where it was simply missing (=
e.g.
> idetape_chrdev_open() etc.)
>=20
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-tape.c |  310 +++++++++++++++++---------------------=
----------
>  1 files changed, 107 insertions(+), 203 deletions(-)
>=20
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index efb9d25..a2e7df0 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -103,24 +103,27 @@ typedef struct os_dat_s {
>  #define IDETAPE_MAX_PIPELINE_STAGES	400
>  #define IDETAPE_INCREASE_STAGES_RATE	 20
> =20
> -/*
> - *	The following are used to debug the driver:
> - *
> - *	Setting IDETAPE_DEBUG_LOG to 1 will log driver flow control.
> - *	some places.
> - *
> - *	Setting them to 0 will restore normal operation mode:
> - *
> - *		1.	Disable logging normal successful operations.
> - *		2.	Disable self-sanity checks.
> - *		3.	Errors will still be logged, of course.
> - *
> - *	All the #if DEBUG code will be removed some day, when the driver
> - *	is verified to be stable enough. This will make it much more
> - *	esthetic.
> - */
> +enum {
> +	DBG_ERR =3D		(1 << 0),
> +	DBG_SENSE =3D		(1 << 1),
> +	DBG_CHRDEV =3D		(1 << 2),
> +	DBG_PROCS =3D		(1 << 3),
> +	DBG_PCRQ_STACK =3D	(1 << 4),
> +};
> +
> +/* define to see debug info */
>  #define IDETAPE_DEBUG_LOG		0
> =20
> +#if IDETAPE_DEBUG_LOG
> +#define debug_log(lvl, fmt, args...)			\
> +{							\
> +	if (tape->debug_level & lvl)			\
> +	printk(KERN_INFO "ide-tape: " fmt, ## args)	\
> +}
> +#else
> +#define debug_log(lvl, fmt, args...) do {} while (0)
> +#endif
> +

with IDETAPE_DEBUG_LOG defined to 1:

drivers/ide/ide-tape.c: In function =E2=80=98idetape_next_pc_storage=E2=
=80=99:
drivers/ide/ide-tape.c:929: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_next_rq_storage=E2=
=80=99:
drivers/ide/ide-tape.c:953: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_analyze_error=E2=80=
=99:
drivers/ide/ide-tape.c:988: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_active_next_stage=E2=
=80=99:
drivers/ide/ide-tape.c:1045: warning: format =E2=80=98%f=E2=80=99 expec=
ts type =E2=80=98double=E2=80=99, but argument 2 has type =E2=80=98cons=
t char *=E2=80=99
drivers/ide/ide-tape.c:1045: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_increase_max_pipel=
ine_stages=E2=80=99:
drivers/ide/ide-tape.c:1073: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_remove_stage_head=E2=
=80=99:
drivers/ide/ide-tape.c:1119: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_abort_pipeline=E2=80=
=99:
drivers/ide/ide-tape.c:1154: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_end_request=E2=80=99=
:
drivers/ide/ide-tape.c:1182: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_request_sense_call=
back=E2=80=99:
drivers/ide/ide-tape.c:1247: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_postpone_request=E2=
=80=99:
drivers/ide/ide-tape.c:1333: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_pc_intr=E2=80=99:
drivers/ide/ide-tape.c:1359: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:1392: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:1398: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:1418: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:1424: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:1481: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:1505: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_issue_packet_comma=
nd=E2=80=99:
drivers/ide/ide-tape.c:1640: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_pc_callback=E2=80=99=
:
drivers/ide/ide-tape.c:1679: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_rw_callback=E2=80=99=
:
drivers/ide/ide-tape.c:1810: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_do_request=E2=80=99=
:
drivers/ide/ide-tape.c:1886: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_kmalloc_stage=E2=80=
=99:
drivers/ide/ide-tape.c:2079: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_add_stage_tail=E2=80=
=99:
drivers/ide/ide-tape.c:2179: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_read_position_call=
back=E2=80=99:
drivers/ide/ide-tape.c:2224: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:2228: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:2229: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:2236: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_read_position=E2=80=
=99:
drivers/ide/ide-tape.c:2378: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_queue_rw_tail=E2=80=
=99:
drivers/ide/ide-tape.c:2511: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_add_chrdev_write_r=
equest=E2=80=99:
drivers/ide/ide-tape.c:2619: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_add_chrdev_read_re=
quest=E2=80=99:
drivers/ide/ide-tape.c:2857: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_rewind_tape=E2=80=99=
:
drivers/ide/ide-tape.c:2955: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_blkdev_ioctl=E2=80=
=99:
drivers/ide/ide-tape.c:2982: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_chrdev_read=E2=80=99=
:
drivers/ide/ide-tape.c:3114: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c:3156: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_chrdev_write=E2=80=
=99:
drivers/ide/ide-tape.c:3177: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_mtioctop=E2=80=99:
drivers/ide/ide-tape.c:3336: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_chrdev_ioctl=E2=80=
=99:
drivers/ide/ide-tape.c:3474: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_chrdev_open=E2=80=99=
:
drivers/ide/ide-tape.c:3534: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
drivers/ide/ide-tape.c: In function =E2=80=98idetape_chrdev_release=E2=80=
=99:
drivers/ide/ide-tape.c:3633: error: expected =E2=80=98;=E2=80=99 before=
 =E2=80=98}=E2=80=99 token
make[1]: *** [drivers/ide/ide-tape.o] Error 1
make: *** [drivers/ide/ide-tape.o] Error 2

after adding missing ';' after printk()...

drivers/ide/ide-tape.c: In function =E2=80=98idetape_active_next_stage=E2=
=80=99:
drivers/ide/ide-tape.c:1045: warning: format =E2=80=98%f=E2=80=99 expec=
ts type =E2=80=98double=E2=80=99, but argument 2 has type =E2=80=98cons=
t char *=E2=80=99
drivers/ide/ide-tape.c: In function =E2=80=98idetape_chrdev_open=E2=80=99=
:
drivers/ide/ide-tape.c:3534: warning: =E2=80=98tape=E2=80=99 is used un=
initialized in this function

>  /*
>   *	After each failed packet command we issue a request sense command
>   *	and retry the packet command IDETAPE_MAX_PC_RETRIES times.
> @@ -557,7 +560,7 @@ typedef struct ide_tape_obj {
>           * 5 : 4+include pc_stack rq_stack info
>           * 6 : 5+USE_COUNT updates
>           */

the above documentation needs to be updated/merged with DBG_* enums

> -         int debug_level;=20
> +         u32 debug_level;

debug_level -> debug_mask

also checkpatch.pl complaints about this line:

ERROR: use tabs not spaces
#72: FILE: drivers/ide/ide-tape.c:563:
+         u32 debug_level;$

[...]

the rest of the patch looks fine

Please recast/resubmit.

Thanks,
Bart

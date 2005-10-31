From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Mon, 31 Oct 2005 15:20:15 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0510311505500.21927@shark.he.net>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF22@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:5578 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932287AbVJaXUQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2005 18:20:16 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 31 Oct 2005 15:20:15 -0800
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BF22@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Mon, 31 Oct 2005, Timothy Thelin wrote:

> IDE taskfile passthru was limited to 128K data transfers
> because of its use of a single kmalloc. This patch makes
> the passthru use a single __get_free_pages instead so the
> codepath remains conceptually the same but the data
> transfer limit is raised to 2MB.  This new limit is
> needed for firmware updates (download microcode) and
> extended commands with larger transfers.

You tested this, with 1-2 MB transfers?  Just want confirmation.
After lots of memory usage, multi-order allocs in Linux
aren't very much of a sure thing.

Please read/study kernel CodingStyle so that we can
review the patch content and functionality instead
of nit-picking the incorrect style.


> Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>
>
> Its attached since what's below is going to get wrapped.
>
> ---
>
> diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -511,6 +511,33 @@ int ide_raw_taskfile (ide_drive_t *drive
>
>  EXPORT_SYMBOL(ide_raw_taskfile);
>
> +int ide_xfrsize_to_pageorder (int size)

'static' if it's not called from anywhere else.
and no space before "(int size)".

> +{
> +	int pageorder, x, num;
> +
> +	num = size / PAGE_SIZE;
> +	if( size % PAGE_SIZE )
> +		++num;
> +
> +	/* figure out the smallest pageorder that has at least num pages */
> +	pageorder = 0;
> +	for( x = sizeof(num) * 8 - 1; x >= 0; --x )

	for (x .... --x) {

> +	{
> +		if( (num >> x) & 1 )

	Spaces go as in:  if (x || y) {
	with the opening brace on the same line.

> +		{
> +			if(pageorder)
	argh.

> +			{
	argh.

> +				return pageorder + 1;
> +			}
> +			else
> +			{

style:			} else {
except no opening/closing braces for one-statment "blocks."

> +				pageorder = x;
> +			}
> +		}
> +	}
> +	return pageorder;
> +}
> +
>  int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long
> arg)
>  {
>  	ide_task_request_t	*req_task;
> @@ -523,6 +550,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
>  	int tasksize		= sizeof(struct ide_task_request_s);
>  	int taskin		= 0;
>  	int taskout		= 0;
> +	int inorder		= 0;
> +	int outorder    = 0;
>  	u8 io_32bit		= drive->io_32bit;
>  	char __user *buf = (char __user *)arg;
>
> @@ -541,7 +570,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
>
>  	if (taskout) {
>  		int outtotal = tasksize;
> -		outbuf = kmalloc(taskout, GFP_KERNEL);
> +		outorder = ide_xfrsize_to_pageorder(taskout);
> +		outbuf = (u8*)__get_free_pages(GFP_KERNEL, outorder);
>  		if (outbuf == NULL) {
>  			err = -ENOMEM;
>  			goto abort;
> @@ -555,7 +585,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
>
>  	if (taskin) {
>  		int intotal = tasksize + taskout;
> -		inbuf = kmalloc(taskin, GFP_KERNEL);
> +		inorder = ide_xfrsize_to_pageorder(taskin);
> +		inbuf = (u8*)__get_free_pages(GFP_KERNEL, inorder);
>  		if (inbuf == NULL) {
>  			err = -ENOMEM;
>  			goto abort;
> @@ -650,9 +681,9 @@ int ide_taskfile_ioctl (ide_drive_t *dri
>  abort:
>  	kfree(req_task);
>  	if (outbuf != NULL)
> -		kfree(outbuf);
> +		free_pages((unsigned long)outbuf, outorder);
>  	if (inbuf != NULL)
> -		kfree(inbuf);
> +		free_pages((unsigned long)inbuf, inorder);
>
>  //	printk("IDE Taskfile ioctl ended. rc = %i\n", err);

-- 
~Randy

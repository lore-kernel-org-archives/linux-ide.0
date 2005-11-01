From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: RE: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Tue, 1 Nov 2005 11:17:43 -0800
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BF2E@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:24847 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1751168AbVKATRr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2005 14:17:47 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


Hi again,

I had a brain malfunction and gave the wrong email
address on the signed-off line, sorry about that.

Here is the correct one:
Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>

Regards,
Tim Thelin

> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org
> [mailto:linux-ide-owner@vger.kernel.org]On Behalf Of Timothy Thelin
> Sent: Tuesday, November 01, 2005 11:06 AM
> To: Bartlomiej Zolnierkiewicz; linux-ide@vger.kernel.org
> Subject: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile 
> transfers
> 
> 
> Hi all,
> 
> Here is for review the cleaned up version of the patch
> that allows ide taskfile transfers to be larger than 128K.
> 
> I've validated on my x86 that its possible to do 4MB
> read sectors extended and write sectors extended, smaller
> transfers with smart read log and smart write log, and
> some non-data commands.
> 
> It's attached as well, since what's below is going to get
> line wrapped.
> 
> Thanks,
> Tim Thelin
> 
> Changes:
> Increases the taskfile data transfer limit from 128K to a
> theoretical 2-4MB (arch dependant) by using __get_free_pages
> instead of kmalloc.  Note that larger requests have a lower
> success rate because of needing to find a larger amount of
> free consecutive memory.
> 
> Signed-off-by: Timothy Thelin <tthelin@wdc.com>
> 
> ============
> 
> diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -511,6 +511,27 @@ int ide_raw_taskfile (ide_drive_t *drive
>  
>  EXPORT_SYMBOL(ide_raw_taskfile);
>  
> +static int ide_xfrsize_to_pageorder(int size)
> +{
> +	int pageorder, x, num;
> +
> +	num = size / PAGE_SIZE;
> +	if (size % PAGE_SIZE)
> +		++num;
> +
> +	pageorder = 0;
> +	for (x = sizeof(num) * 8 - 1; x >= 0; --x) {
> +		if ((num >> x) & 1) {
> +			if (pageorder) {
> +				++pageorder;
> +				break;
> +			} else
> +				pageorder = x;
> +		}
> +	}
> +	return pageorder;
> +}
> +
>  int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int 
> cmd, unsigned long
> arg)
>  {
>  	ide_task_request_t	*req_task;
> @@ -523,6 +544,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
>  	int tasksize		= sizeof(struct ide_task_request_s);
>  	int taskin		= 0;
>  	int taskout		= 0;
> +	int inorder		= 0;
> +	int outorder    	= 0;
>  	u8 io_32bit		= drive->io_32bit;
>  	char __user *buf = (char __user *)arg;
>  
> @@ -541,7 +564,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
>  
>  	if (taskout) {
>  		int outtotal = tasksize;
> -		outbuf = kmalloc(taskout, GFP_KERNEL);
> +		outorder = ide_xfrsize_to_pageorder(taskout);
> +		outbuf = (u8*)__get_free_pages(GFP_KERNEL, outorder);
>  		if (outbuf == NULL) {
>  			err = -ENOMEM;
>  			goto abort;
> @@ -555,7 +579,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
>  
>  	if (taskin) {
>  		int intotal = tasksize + taskout;
> -		inbuf = kmalloc(taskin, GFP_KERNEL);
> +		inorder = ide_xfrsize_to_pageorder(taskin);
> +		inbuf = (u8*)__get_free_pages(GFP_KERNEL, inorder);
>  		if (inbuf == NULL) {
>  			err = -ENOMEM;
>  			goto abort;
> @@ -650,9 +675,9 @@ int ide_taskfile_ioctl (ide_drive_t *dri
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
>  
> 

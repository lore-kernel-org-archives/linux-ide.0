From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/12] ide: remove task_ioreg_t typedef
Date: Wed, 24 Oct 2007 23:27:48 +0200
Message-ID: <200710242327.48474.bzolnier@gmail.com>
References: <200710082310.04079.bzolnier@gmail.com> <47164A94.1070502@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:15191 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbXJXXcf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 19:32:35 -0400
Received: by nf-out-0910.google.com with SMTP id g13so325235nfb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 16:32:34 -0700 (PDT)
In-Reply-To: <47164A94.1070502@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Wednesday 17 October 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Remove task_ioreg_t typedef from the kernel code (but leave it
> > in <linux/hdreg.h> for #ifndef/#endif __KERNEL__ case).
> 
> > While at it also move sata_ioreg_t typedef under #ifndef/#endif __KERNEL__.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/include/linux/hdreg.h
> > ===================================================================
> > --- a/include/linux/hdreg.h
> > +++ b/include/linux/hdreg.h
> [...]
> > @@ -116,8 +116,8 @@ typedef union ide_reg_valid_s {
> >  } ide_reg_valid_t;
> >  
> >  typedef struct ide_task_request_s {
> > -	task_ioreg_t	io_ports[8];
> > -	task_ioreg_t	hob_ports[8];
> > +	__u8		io_ports[8];
> > +	__u8		hob_ports[8];
> >  	ide_reg_valid_t	out_flags;
> >  	ide_reg_valid_t	in_flags;
> >  	int		data_phase;
> > @@ -133,32 +133,32 @@ typedef struct ide_ioctl_request_s {
> >  } ide_ioctl_request_t;
> >  
> >  struct hd_drive_cmd_hdr {
> > -	task_ioreg_t command;
> > -	task_ioreg_t sector_number;
> > -	task_ioreg_t feature;
> > -	task_ioreg_t sector_count;
> > +	__u8 command;
> > +	__u8 sector_number;
> > +	__u8 feature;
> > +	__u8 sector_count;
> >  };
> >  
> >  typedef struct hd_drive_task_hdr {
> > -	task_ioreg_t data;
> > -	task_ioreg_t feature;
> > -	task_ioreg_t sector_count;
> > -	task_ioreg_t sector_number;
> > -	task_ioreg_t low_cylinder;
> > -	task_ioreg_t high_cylinder;
> > -	task_ioreg_t device_head;
> > -	task_ioreg_t command;
> > +	__u8 data;
> > +	__u8 feature;
> > +	__u8 sector_count;
> > +	__u8 sector_number;
> > +	__u8 low_cylinder;
> > +	__u8 high_cylinder;
> > +	__u8 device_head;
> > +	__u8 command;
> >  } task_struct_t;
> >  
> >  typedef struct hd_drive_hob_hdr {
> > -	task_ioreg_t data;
> > -	task_ioreg_t feature;
> > -	task_ioreg_t sector_count;
> > -	task_ioreg_t sector_number;
> > -	task_ioreg_t low_cylinder;
> > -	task_ioreg_t high_cylinder;
> > -	task_ioreg_t device_head;
> > -	task_ioreg_t control;
> > +	__u8 data;
> > +	__u8 feature;
> > +	__u8 sector_count;
> > +	__u8 sector_number;
> > +	__u8 low_cylinder;
> > +	__u8 high_cylinder;
> > +	__u8 device_head;
> > +	__u8 control;
> >  } hob_struct_t;
> 
>     Why use __u8 here, and u8 elsewhere?

<linux/hdreg.h> can be also used by the user-space applications
in which case u8 is not available.

> >  #define TASKFILE_INVALID		0x7fff
> > Index: b/include/linux/ide.h
> > ===================================================================
> > --- a/include/linux/ide.h
> > +++ b/include/linux/ide.h
> > @@ -1017,7 +1017,8 @@ int ide_end_dequeued_request(ide_drive_t
> >  
> >  extern void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler, unsigned int timeout, ide_expiry_t *expiry);
> >  
> > -extern void ide_execute_command(ide_drive_t *, task_ioreg_t cmd, ide_handler_t *, unsigned int, ide_expiry_t *);
> > +void ide_execute_command(ide_drive_t *, u8 cmd, ide_handler_t *,
> > +			 unsigned int, ide_expiry_t *);
> 
>     Hm, why name only second parameter? :-|

No reason to, patch updated to remove 'cmd' name from the above declaration
(this is the only change in 'take 2').

Thanks,
Bart

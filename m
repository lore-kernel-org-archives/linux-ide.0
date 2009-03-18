From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/4] ide: call {in|out}put_data() methods from tf_{read|load}()
 methods
Date: Wed, 18 Mar 2009 21:09:16 +0300
Message-ID: <49C138CC.7010507@ru.mvista.com>
References: <200903182043.57246.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:38567 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754056AbZCRSIc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 14:08:32 -0400
In-Reply-To: <200903182043.57246.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

> Handle IDE_FTFLAG_{IN|OUT}_DATA flags in tf_{read|load}() methods by calling
> {in|out}put_data() methods to transfer 2 bytes -- this will allow us to move
> that handling out of those methods altogether...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Will have to repost this, sigh...

> Index: linux-2.6/drivers/ide/scc_pata.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/scc_pata.c
> +++ linux-2.6/drivers/ide/scc_pata.c
> @@ -656,9 +656,11 @@ static void scc_tf_load(ide_drive_t *dri
>  	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
>  		HIHI = 0xFF;
>  
> -	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA)
> -		out_be32((void *)io_ports->data_addr,
> -			 (tf->hob_data << 8) | tf->data);
> +	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
> +		u8 data[2] = { tf->data, tf->hob_data };
> +
> +		scc_output_data(drive, NULL, data, 2);
> +	}
>  
>  	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
>  		scc_ide_outb(tf->hob_feature, io_ports->feature_addr);
> @@ -693,10 +695,12 @@ static void scc_tf_read(ide_drive_t *dri
>  	struct ide_taskfile *tf = &cmd->tf;
>  
>  	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
> -		u16 data = (u16)in_be32((void *)io_ports->data_addr);
> +		u8 data[2];
> +
> +		ide_input_data(drive, cmd, data, 2);

    Oops, this should've been scc_input_data(). It's good that I had a glance 
at it after posting... :-<

MBR, Sergei

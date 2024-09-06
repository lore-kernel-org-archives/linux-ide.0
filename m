Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF11CEAA5
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647949; cv=none; b=rk3gHBkJ/F0xwB4smcgWKqFol134JL5o5SvllHcLcBqWLxz8TyqHk6L0I3v2HFlqVTSJEP6J8TVG4y/788h1w3rH9mj8Tqb3fDlewBfzZabLX7hs5K1IlEUZ3aS4Rvzw7kiljinpw9XRlBjVkLeuSUr/OanW01XtBD6Y5LUVJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647949; c=relaxed/simple;
	bh=aBcq9azq8aM7DMi+iF1qAAaDYP44ci+tojOwfIf9ydU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhJfC9nFNIYXhQ1+TH6N2ZlVL7RQ8SfYBc3T2wbtFI7IhKWxwFH7RRQoeGOW9sV8wWlauQYpTR/v3YQXMkZ+1YpKspUBaSmpl+smTniEp3d8uRXSkTC80j+Rpy7hZlbLGd2xJ7zi0PVgbRyg0ZuyEPEpMcO7opT7LfoJKgnoJ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nicZZBs/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nicZZBs/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20546b8e754so24725ad.1
        for <linux-ide@vger.kernel.org>; Fri, 06 Sep 2024 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725647947; x=1726252747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpfmjQZEdanvkZ5dthiVKYfIFI2CBRvDQVq0d3+n8xo=;
        b=nicZZBs/qqb38uiZN46OEEOi0vfQHXzRLI2HiacyMGLGi6RMaxZNx+zse5s81l+9vb
         6mrmxtwCxSoTqvvLsaWlxdb9EVKpmwdTBM1f3gXtPwNEA/FGjvgv9ya/QKb7ZgUaNMfa
         +/V1TgXL+/xAJtAk+bYmXGaX0SH+ucr6sTqgfT8DsRGnCDHSRPTJdOmF+jAmsz7kDXIC
         VqWwlsF7W/I7f7lZUs/Dzup4qhfEqUqghTSwlOlqmrTNv9GvXYMEbriJjgHTKJ/72/iT
         BKlJArYfOHKEDBpyLud0R/CZGdwjdm/0NUREw/YTPF532y2F6jg+FMYAAPmEAGlDU1fJ
         /nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725647947; x=1726252747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpfmjQZEdanvkZ5dthiVKYfIFI2CBRvDQVq0d3+n8xo=;
        b=qJRrwKrUVmUQ4kArEkzzijo2JlCIMtTwb9MDacQdI+0BAMUFDe85AaczTBn32lKfIW
         zUICMccEjkp5RjFoRvZ3yP675uqL7xdcw1PGmIaODUSRWbHlIOVCu+tQkcM/MdDA8ygC
         vR4qqZmO+1A6UyoN9AI2asw9ifRxtXEP8WjcSwK2wnLlUGHxHNs+z+N/yYWXquxKgsGF
         n4rTJoTK+imG7gMozg00ZrCvEVA+5tmBLGe0+ifH0EV+VQlqp0s9BqEtQqhxqsxpu3ZK
         M8fQtXoGVMtlBkv50EFQn+NkGd4HaAk0mv5Ffzc0qJ2I0dk7hLvEUqsjx8WDBdS5UsFl
         I50A==
X-Forwarded-Encrypted: i=1; AJvYcCVEfzeF4haoS1PbQihHM86qgnfZRxC0Y1ythnZOXGaH3CLAbaGyEmqpg7UvlB2SL/4+jTEvr/Iov6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YybNpQKuiTZGQy78giwv311JnMZ+HNsO3o1aG7CbQAyaqNJWs2X
	rAVssjx/7kvNaqKFgs68/63oXuclOksupfegFOnap2STxjiB92di3LrYksM3GM05cseDrHUBjjo
	FRw==
X-Google-Smtp-Source: AGHT+IFXD8CVf6qjkQsDFUpybZoL63gNlJ64OySYNihShuoQXM6WGaKGPO1U3e1QeD0mDkiGOb38Ew==
X-Received: by 2002:a17:902:ce81:b0:1fd:8c42:61ce with SMTP id d9443c01a7336-2070b7c6ab0mr184215ad.27.1725647946695;
        Fri, 06 Sep 2024 11:39:06 -0700 (PDT)
Received: from google.com (35.72.105.34.bc.googleusercontent.com. [34.105.72.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67c00sm45821605ad.273.2024.09.06.11.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:39:06 -0700 (PDT)
Date: Fri, 6 Sep 2024 18:39:03 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata: Clear DID_TIME_OUT at the start of EH
 instead of at the end
Message-ID: <ZttMR5JjF71eQI1C@google.com>
References: <20240906142720.1977225-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906142720.1977225-2-cassel@kernel.org>

On Fri, Sep 06, 2024 at 04:27:21PM +0200, Niklas Cassel wrote:
> When ata_qc_complete() schedules a command for EH using
> ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
> req->q->mq_ops->timeout() / scsi_timeout() being called.
> 
> scsi_timeout(), if the LLDD has no abort handler (libata has no abort
> handler), will set host byte to DID_TIME_OUT, and then call
> scsi_eh_scmd_add() to add the command to EH.
> 
> Thus, when commands first enter libata's EH strategy_handler, all the
> commands that have been added to EH will have DID_TIME_OUT set.
> 
> libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
> have not received a completion at the time of entering EH.
> 
> Thus, we don't really care about DID_TIME_OUT at all, and currently clear
> the host byte at the end of EH, in ata_scsi_qc_complete(), before
> scsi_eh_finish_cmd() is called.
> 
> ata_scsi_qc_complete() will be called both for commands that are completed
> normally (without going via EH), and for commands that went via EH.
> 
> It seems more appropriate to clear DID_TIME_OUT at the start of EH instead
> of at the end of EH. That way, someone dumping the host byte at the middle
> of EH will not see DID_TIME_OUT as being set. No functional change
> intended.
> 
> This has the additional advantage that we will not needlessly clear the
> host byte for commands that did not go via EH.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Thank you for coming up with this generic solution, Niklas!

I tested the patch with sg_sat_read_gplog. Without the fix we can see that
DID_TIME_OUT is being reported to user space. The issue is gone with the fix
applied.

Without the fix:                                                             
----------------                                                                 
$ sg_sat_read_gplog -a 30 -p 9 --dma -vv /dev/sda                               
open /dev/sda with flags=0x802                                                  
Building ATA READ LOG DMA EXT command; la=0x1e, pn=0x9, this_count=1            
    ATA pass-through(16) cdb: [85 0d 0e 00 00 00 01 00 1e 00 09 00 00 00 47 00] 
ATA pass-through(16): transport error: Host_status=0x03 [DID_TIME_OUT]          
Driver_status=0x08 [DRIVER_SENSE]                        ^^^^^^^^^^^^           
                                                                                
ATA pass-through(16):                                                           
    Fixed format, current; Sense key: Illegal Request                           
    ASC=24, ASCQ=00 (hex)                                                       
      Info fld=0x4530001 [72548353]                                             
     Raw sense data (in hex), sb_len=64                                         
            f0 00 05 04 53 00 01 0a  80 1e 09 00 24 00 00 00                    
            00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00                    
            00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00                    
            00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00                    
                                                                                
ATA PASS-THROUGH (16) failed                                                    
                                                                                
$ echo $?                                                                       
99                                                                              
                                                                                
With the fix:                                                                  
-------------                                                                  
$ sg_sat_read_gplog -a 30 -p 9 --dma -vv /dev/sda                               
open /dev/sda with flags=0x802                                                  
Building ATA READ LOG DMA EXT command; la=0x1e, pn=0x9, this_count=1            
    ATA pass-through(16) cdb: [85 0d 0e 00 00 00 01 00 1e 00 09 00 00 00 47 00] 
ATA pass through:                                                               
Fixed format, current; Sense key: Illegal Request                               
ASC=24, ASCQ=00 (hex)                                                           
  Info fld=0x4530001 [72548353]                                                 
                                                                                
$ echo $?                                                                       
5   


Tested-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> ---
>  drivers/ata/libata-eh.c   | 9 +++++++++
>  drivers/ata/libata-scsi.c | 3 ---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7de97ee8e78b..450e9bd96c97 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -630,6 +630,15 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>  		struct ata_queued_cmd *qc;
>  
> +		/*
> +		 * If the scmd was added to EH, via ata_qc_schedule_eh() ->
> +		 * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
> +		 * have set DID_TIME_OUT (since libata does not have an abort
> +		 * handler). Thus to clear the DID_TIME_OUT, we clear the host
> +		 * byte (but keep the SCSI ML and status byte).
> +		 */
> +		scmd->result &= 0x0000ffff;
> +
>  		ata_qc_for_each_raw(ap, qc, i) {
>  			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>  			    qc->scsicmd == scmd)
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3a442f564b0d..6a90062c8b55 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1680,9 +1680,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
>  	} else if (is_error && !have_sense) {
>  		ata_gen_ata_sense(qc);
> -	} else {
> -		/* Keep the SCSI ML and status byte, clear host byte. */
> -		cmd->result &= 0x0000ffff;
>  	}
>  
>  	ata_qc_done(qc);
> -- 
> 2.46.0
> 

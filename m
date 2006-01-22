From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/12] libata: make the owner of a qc responsible for
 freeing it
Date: Sun, 22 Jan 2006 19:16:03 +0900
Message-ID: <43D35B63.6010704@gmail.com>
References: <1137916710182-git-send-email-htejun@gmail.com> <43D35274.2060402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.192]:13802 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932347AbWAVKQJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 05:16:09 -0500
Received: by xproxy.gmail.com with SMTP id s14so519949wxc
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2006 02:16:08 -0800 (PST)
In-Reply-To: <43D35274.2060402@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> --- a/drivers/scsi/libata-scsi.c
>> +++ b/drivers/scsi/libata-scsi.c
>> @@ -1219,7 +1219,7 @@ nothing_to_do:
>>      return 1;
>>  }
>>  
>> -static int ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>> +static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>>  {
>>      struct scsi_cmnd *cmd = qc->scsicmd;
>>      u8 *cdb = cmd->cmnd;
>> @@ -1256,7 +1256,7 @@ static int ata_scsi_qc_complete(struct a
>>  
>>      qc->scsidone(cmd);
>>  
>> -    return 0;
>> +    ata_qc_free(qc);
>>  }
>>  
>>  /**
>> @@ -1982,7 +1982,7 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
>>      done(cmd);
>>  }
>>  
>> -static int atapi_sense_complete(struct ata_queued_cmd *qc)
>> +static void atapi_sense_complete(struct ata_queued_cmd *qc)
>>  {
>>      if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0))
>>          /* FIXME: not quite right; we don't want the
>> @@ -1993,7 +1993,7 @@ static int atapi_sense_complete(struct a
>>          ata_gen_ata_desc_sense(qc);
>>  
>>      qc->scsidone(qc->scsicmd);
>> -    return 0;
>> +    ata_qc_free(qc);
>>  }
>>  
>>  /* is it pointless to prefer PIO for "safety reasons"? */
>> @@ -2050,7 +2050,7 @@ static void atapi_request_sense(struct a
>>      DPRINTK("EXIT\n");
>>  }
>>  
>> -static int atapi_qc_complete(struct ata_queued_cmd *qc)
>> +static void atapi_qc_complete(struct ata_queued_cmd *qc)
>>  {
>>      struct scsi_cmnd *cmd = qc->scsicmd;
>>      unsigned int err_mask = qc->err_mask;
>> @@ -2060,7 +2060,7 @@ static int atapi_qc_complete(struct ata_
>>      if (unlikely(err_mask & AC_ERR_DEV)) {
>>          cmd->result = SAM_STAT_CHECK_CONDITION;
>>          atapi_request_sense(qc);
>> -        return 1;
>> +        return;
>>      }
>>  
>>      else if (unlikely(err_mask))
>> @@ -2100,7 +2100,7 @@ static int atapi_qc_complete(struct ata_
>>      }
>>  
>>      qc->scsidone(cmd);
>> -    return 0;
>> +    ata_qc_free(qc);
> 
> 
> 
> Can you describe the ATAPI error handling flow, after applying these two 
> changes (patch #1 and this one, patch #2)?
> 

Sure.  Except for where ata_qc_free() is called, it isn't different from 
the original.

A. Before change.

1. ATAPI qc completes with ERR_DEV.
2. ata_qc_complete calls atapi_qc_complete which in turn sees AC_ERR_DEV 
and calls atapi_request_sense.
3. atapi_request_sense re-init qc and issues it again for REQUEST SENSE
4. atapi_qc_complete returns 1 to instruct ata_qc_complete to not call 
ata_qc_free().
5. REQUEST_SENSE completes.  ata_qc_complete is called and it calls 
atapi_sense_complete() which notifies SCSI layer and returns 0.
6. ata_qc_complete sees return value 0 and calls ata_qc_free().

B. After change.

1. ATAPI qc completes with ERR_DEV.
2. ata_qc_complete calls atapi_qc_complete which in turn sees AC_ERR_DEV 
and calls atapi_request_sense.
3. atapi_request_sense re-init qc and issues it again for REQUEST SENSE.
4. atapi_qc_complete returns without calling ata_qc_free. 
ata_qc_complete finishes.  qc isn't freed and still in-flight.
5. REQUEST_SENSE completes.  ata_qc_complete is called and it calls 
atapi_sense_complete() which notifies SCSI layer, free's the qc and returns.
6. ata_qc_complete returns.

-- 
tejun

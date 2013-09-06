From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH/RESEND 2/2] Hard disk S3 resume time optimization
Date: Fri, 06 Sep 2013 16:37:00 +0400
Message-ID: <5229CC6C.5010705@cogentembedded.com>
References: <20130906004425.GA31998@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20130906004425.GA31998@linux.intel.com>
Sender: linux-scsi-owner@vger.kernel.org
To: todd.e.brandt@linux.intel.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org, JBottomley@parallels.com
List-Id: linux-ide@vger.kernel.org

Hello.

On 06-09-2013 4:44, Todd E Brandt wrote:

> Part 2 of the hard disk resume optimization patch, this one applies
> to the scsi subsystem.

    Don't give the same name to both patches. In this case, you could prefix 
the patch name with e.g. "sd: ".

> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

>   drivers/scsi/sd.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 1 deletion(-)

> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 86fcf2c..d4bf784 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
[...]
> @@ -3137,6 +3138,85 @@ done:
>   	return ret;
>   }
>
> +static void sd_resume_async_end(struct request *rq, int error)
> +{
> +	struct scsi_sense_hdr sshdr;
> +	struct scsi_disk *sdkp = rq->end_io_data;
> +	char *sense = rq->sense;
> +
> +	if (error) {
> +		sd_printk(KERN_WARNING, sdkp, "START FAILED\n");
> +		sd_print_result(sdkp, error);
> +		if (sense && (driver_byte(error) & DRIVER_SENSE)) {
> +			scsi_normalize_sense(sense,
> +				SCSI_SENSE_BUFFERSIZE, &sshdr);
> +			sd_print_sense_hdr(sdkp, &sshdr);
> +		}
> +	} else
> +		sd_printk(KERN_NOTICE, sdkp, "START SUCCESS\n");

    According to Documentation/CodingStyle, both arms of the *if* statement 
should have {} when one arm has them.

WBR, Sergei


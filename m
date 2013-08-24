From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH v3 2/2] Hard disk S3 resume time optimization
Date: Sat, 24 Aug 2013 10:21:25 +0200
Message-ID: <1377332485.1790.3.camel@linux-fkkt.site>
References: <20130823214340.GC11321@todd.e.brandt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20130823214340.GC11321@todd.e.brandt@intel.com>
Sender: linux-scsi-owner@vger.kernel.org
To: "Brandt, Todd E" <todd.e.brandt@intel.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org, gregkh@linuxfoundation.org, stern@rowland.harvard.edu
List-Id: linux-ide@vger.kernel.org

On Fri, 2013-08-23 at 14:43 -0700, Brandt, Todd E wrote:
> This is v3 of the non-blocking S3 resume patch. It's been broken into
> two pieces, this part is for the scsi subsystem. I've addressed Alan 
> Stern's comments in particular by reformatting the call to conform
> to the proper style guidelines.

Hi,

you are changing the generic resume for all sd disks.
In particular, you are dropping the check of
sdkp->device->manage_start_stop
What happens if you use this patch on a real SCSI disk?

	Regards
		Oliver



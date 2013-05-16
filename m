From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Hard disk S3 resume time optimization
Date: Thu, 16 May 2013 15:47:48 -0700
Message-ID: <20130516224748.GB14875@mtj.dyndns.org>
References: <11E08D716F0541429B7042699DD5C1A16B97B58D@FMSMSX103.amr.corp.intel.com>
 <20130516224441.GA14875@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130516224441.GA14875@mtj.dyndns.org>
Sender: linux-scsi-owner@vger.kernel.org
To: "Brandt, Todd E" <todd.e.brandt@intel.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "arjan@linux.intel.com" <arjan@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

On Thu, May 16, 2013 at 03:44:41PM -0700, Tejun Heo wrote:
> So, while I agree about the problem and the solution seems to be
> headed the right way of making SCSI suspend/resume asynchronous,
> what's going on with patch splitting, submission format and comments?
> Please read up on patch submission (there gotta be enough people in
> OSTC to point you to the right direction) and retry.

Please also cc Rafael J. Wysocki <rjw@sisk.pl> and
linux-pm@vger.kernel.org next time.

Thanks!

-- 
tejun

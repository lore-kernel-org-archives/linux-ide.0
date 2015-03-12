From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: revert "libata: use blk taging" et al.
Date: Thu, 12 Mar 2015 08:11:57 -0400
Message-ID: <20150312121157.GH25944@htj.duckdns.org>
References: <5500863D.4070807@cybernetics.com>
 <5500B783.20106@fb.com>
 <5500BF6F.6080000@cybernetics.com>
 <20150312023148.GA1960870@devbig257.prn2.facebook.com>
 <CAPcyv4izOUB93ySh1Qua6qbDC8utgCjY5Zj__NbUXvS9MNY5EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4izOUB93ySh1Qua6qbDC8utgCjY5Zj__NbUXvS9MNY5EQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Shaohua Li <shli@fb.com>, Tony Battersby <tonyb@cybernetics.com>, Jens Axboe <axboe@fb.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Mar 12, 2015 at 06:14:24AM -0400, Dan Williams wrote:
> > @@ -572,7 +572,6 @@ int sas_ata_init(struct domain_device *found_dev)
> >
> >         ap->private_data = found_dev;
> >         ap->cbl = ATA_CBL_SATA;
> > -       ap->scsi_host = shost;
> >         rc = ata_sas_port_init(ap);
> >         if (rc) {
> >                 ata_sas_port_destroy(ap);
> 
> We need a scsi_host for error recovery, see:
> 
> ata_std_sched_eh()

IOW, let's just add a flag bit to identify SAS hosts.

Thanks.

-- 
tejun

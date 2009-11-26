From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Thin provisioning fixes
Date: Thu, 26 Nov 2009 05:59:47 -0500
Message-ID: <20091126105947.GA28120@infradead.org>
References: <1258771524-26673-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1258771524-26673-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-scsi-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: jens.axboe@oracle.com, james.bottomley@hansenpartnership.com, hch@infradead.org, willy@wil.cx, jgarzik@pobox.com, sandeen@redhat.com, rwheeler@redhat.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

What's the current state of this?

patch 4 is if I see this correctly withdrawn.  patch 1 could go into the
block tree as is, and patch 3 into the libata tree, and patch 2 would
replace the older one in the scsi post merge tree.

Jens, Jeff, James?


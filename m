From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] drivers:ata: Fix spelling typos in libata-scsi.c and the
 header file,ata.h
Date: Thu, 25 Dec 2014 15:28:56 -0500
Message-ID: <20141225202856.GE22951@htj.dyndns.org>
References: <1419219397-14627-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419219397-14627-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Dec 21, 2014 at 10:36:37PM -0500, Nicholas Krause wrote:
> Changes the spelling typos of removeable to removable where ata_id_removeable is defined in
> ata.h and called in libata-scsi.c respectively.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

Well, this isn't exactly wrong but why not?  Applied to
libata/for-3.20 with the description updated.

Thanks.

-- 
tejun

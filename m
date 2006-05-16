From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Fwd: [RFT] major libata update]
Date: Wed, 17 May 2006 01:13:58 +0900
Message-ID: <4469FA46.1010503@gmail.com>
References: <4468B596.9090508@garzik.org>	 <1147789098.3505.19.camel@mulgrave.il.steeleye.com>	 <4469F2B2.703@garzik.org> <1147794708.3505.30.camel@mulgrave.il.steeleye.com> <4469F906.7040602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <4469F906.7040602@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jeff Garzik <jeff@garzik.org>, SCSI Mailing List <linux-scsi@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
[--snip--]
> Currently, there is no reliable way to trigger DID_FAILED
> unconditionally.  I thought about adding some host code or whatever to
> force it but it felt too hackish and went with the
> scsi_eh_schedule_scmd().  Then, Luben suggested scsi_req_abort_cmd(), so
> that's what I've ended up with.

Oops, wasn't thinking straight.  Time to go bad.  The obstacle I
couldn't avoid was the forced scmd timeout in scsi_softirq_done().

-- 
tejun

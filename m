From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Tue, 06 Jan 2015 19:05:40 -0500
Message-ID: <yq1387n8nfv.fsf@sermon.lab.mkp.net>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
	<20141204170611.GB2995@htj.dyndns.org>
	<yq14mtahmil.fsf@sermon.lab.mkp.net>
	<20141205145148.GI4080@htj.dyndns.org>
	<1418184578.2121.3.camel@HansenPartnership.com>
	<20141210142927.GA6294@htj.dyndns.org>
	<yq1oarbcj6f.fsf@sermon.lab.mkp.net>
	<20150105162830.GP15833@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20150105162830.GP15833@htj.dyndns.org> (Tejun Heo's message of
	"Mon, 5 Jan 2015 11:28:30 -0500")
Sender: linux-fsdevel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

>>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:

>> The other use case is the filesystem one where it is common to zero
>> block ranges for bitmaps, etc. In many workloads there's is a
>> significant win to trimming over writing out many blocks of zeroes.

Tejun> Isn't that kinda niche and specialized tho?  

I don't think so. There are two reasons for zeroing block ranges:

 1) To ensure they contain zeroes on subsequent reads

 2) To preallocate them or anchor them down on thin provisioned devices

The filesystem folks have specifically asked to be able to make that
distinction. Hence the patch that changes blkdev_issue_zeroout().

You really don't want to write out gobs and gobs of zeroes and cause
unnecessary flash wear if all you care about is the blocks being in a
deterministic state.

-- 
Martin K. Petersen	Oracle Linux Engineering

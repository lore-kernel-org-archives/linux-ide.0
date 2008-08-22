From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: kernel unaligned accesses on IA64 in IDE
Date: Fri, 22 Aug 2008 11:51:47 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA309EDE187@orsmsx505.amr.corp.intel.com>
References: <20080819225606.GB22088@us.ibm.com>
 <20080822164538.GB9047@us.ibm.com>
 <9ea470500808221029l6bd79c62w4c06d948f962d95c@mail.gmail.com>
 <200808222036.00536.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <200808222036.00536.bzolnier@gmail.com>
Content-Language: en-US
Sender: linux-ia64-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "petkovbb@gmail.com" <petkovbb@gmail.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Robin Holt <holt@sgi.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
List-Id: linux-ide@vger.kernel.org

> Why not just make rq->cmd always properly aligned in the block layer
> i.e. by allocating BLK_MAX_CDB + 2 instead of BLK_MAX_CDB for rq->__cmd
> and then doing ALIGN() when setting rq->cmd in blk_rq_init()?

There are two places that do

        if (rq->cmd != rq->__cmd)
                kfree(rq->cmd);

that would need to be adjusted if you did that.  Better to get __cmd
aligned on a good boundary by changing the declaration to

        int __cmd[BLK_MAX_CDB / sizeof (int)];

and adding a cast to blk_rq_init():

        rq->cmd = (char *)rq->__cmd;

-Tony

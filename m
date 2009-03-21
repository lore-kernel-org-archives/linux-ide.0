From: Mark Lord <liml@rtr.ca>
Subject: Re: Overagressive failing of disk reads, both LIBATA and IDE
Date: Sat, 21 Mar 2009 11:01:40 -0400
Message-ID: <49C50154.7010504@rtr.ca>
References: <F79C774361EF45A6A68BC08F8621E406@DIAMOND8600>	 <49C30E67.4060702@rtr.ca> <1237645333.4600.9.camel@localhost.localdomain> <49C4FFFB.5000601@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759077AbZCUPCA@vger.kernel.org>
In-Reply-To: <49C4FFFB.5000601@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Norman Diamond <n0diamond@yahoo.co.jp>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
..
> I think it could be even more clever, using a binary search or something
> on the remaining chunks, so that it takes less time to skip over a huge
> stretch of sequential bad sectors (scratch on media).  That would probably
> be best all around.
..

Heh.. pity that spinning media cannot do a "READ BACKWARDS" type of operation.

:)

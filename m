From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for February 9 (ide-dma)
Date: Mon, 09 Feb 2009 09:15:56 -0800
Message-ID: <499064CC.1030907@oracle.com>
References: <20090209193908.1a448944.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090209193908.1a448944.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

Stephen Rothwell wrote:
> Hi all,
> 
> [I accidentally deleted the merge and quilt-import logs today :-( - I
> wonder if any would have noticed :-).  The merge summary still appears
> below.]
> 
> Changes since 20090206:
> 
> New tree:
> 	aoe
> 
> Undropped trees:
> 	ide


When CONFIG_BLK_DEV_IDEDMA=n:

drivers/ide/ide-taskfile.c:104: error: implicit declaration of function 'ide_build_sglist'

-- 
~Randy

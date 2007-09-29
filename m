From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: sata_sil24 with port multiplier
Date: Fri, 28 Sep 2007 23:47:41 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0709282343230.28332@trinity.phys.uwm.edu>
References: <FD6311B7ED175B4480F31633F6098B4D911D1F@ffpglobal_mail.corp.ffplus.net>
	<46FD7699.9010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <smartmontools-support-bounces@lists.sourceforge.net>
In-Reply-To: <46FD7699.9010404@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=smartmontools-support>
List-Post: <mailto:smartmontools-support@lists.sourceforge.net>
List-Help: <mailto:smartmontools-support-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=subscribe>
Sender: smartmontools-support-bounces@lists.sourceforge.net
Errors-To: smartmontools-support-bounces@lists.sourceforge.net
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, Jon Chelton <jchelton@ffpglobal.com>, Bruce Allen <bruce.allen@aei.mpg.de>
List-Id: linux-ide@vger.kernel.org

> All errors are interface CRC errors reported by device on FPDMA_WRITE. 
> It doesn't seem to have anything to do with SMART.  In all cases, SError 
> DIAG is reporting handshake error too (R_ERR received).  I'm fairly sure 
> these were actual hardware problems.  You don't have to pay too much 
> attention unless it happens repeatedly.  Good cure for the problem is 
> probably to re-seat the harddrive.

Jon: as Tejun says, the ICRC errors indicate a problem with the data 
cabling or connections between the drive and the controller.  Replug, 
clean, examine (and perhaps replace) SATA cables and/or connectors. The 
SMART error log (smartctl -L) might also show entries for the ICRC errors 
(with timestamps that might be useful).

> Bruce, I don't think this is SMART related.  Sorry about the noise. 
> Thanks.

Tejun: thank you again, no worries, and definitely no apologies needed!

Cheers,
 	Bruce

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

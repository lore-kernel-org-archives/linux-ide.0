From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: sata_sil24 with port multiplier
Date: Tue, 2 Oct 2007 07:07:04 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0710020706020.2741@trinity.phys.uwm.edu>
References: <FD6311B7ED175B4480F31633F6098B4D911D2A@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <smartmontools-support-bounces@lists.sourceforge.net>
In-Reply-To: <FD6311B7ED175B4480F31633F6098B4D911D2A@ffpglobal_mail.corp.ffplus.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=smartmontools-support>
List-Post: <mailto:smartmontools-support@lists.sourceforge.net>
List-Help: <mailto:smartmontools-support-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=subscribe>
Sender: smartmontools-support-bounces@lists.sourceforge.net
Errors-To: smartmontools-support-bounces@lists.sourceforge.net
To: Tejun Heo <htejun@gmail.com>, Jon Chelton <jchelton@ffpglobal.com>
Cc: linux-ide@vger.kernel.org, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, Bruce Allen <bruce.allen@aei.mpg.de>
List-Id: linux-ide@vger.kernel.org

Jon: always nice when computers act like finite-state machines, not like 
incomprehensible organic devices.

Tejun: thanks again.

Cheers,
 	Bruce

On Sat, 29 Sep 2007, Jon Chelton wrote:

> Thanks Bruce and Tejun,
>
> I have replaced the hot swap drive tray of the drive in question,
> rebooted and reinstalled the latest version of smartmontools.  So far I
> have read and wrote about 50GB of data to the raid array over the last
> 18 hours with smartd running and have not seen any kernel error
> messages.  Looks like the interconnect was at fault.
>
> Thanks again for the help,
> Jon
>
> -----Original Message-----
> From: Bruce Allen [mailto:ballen@gravity.phys.uwm.edu]
> Sent: Friday, September 28, 2007 9:48 PM
> To: Tejun Heo
> Cc: Jon Chelton; Bruce Allen; Smartmontools Mailing List;
> linux-ide@vger.kernel.org
> Subject: Re: sata_sil24 with port multiplier
>
>> All errors are interface CRC errors reported by device on FPDMA_WRITE.
>
>> It doesn't seem to have anything to do with SMART.  In all cases,
> SError
>> DIAG is reporting handshake error too (R_ERR received).  I'm fairly
> sure
>> these were actual hardware problems.  You don't have to pay too much
>> attention unless it happens repeatedly.  Good cure for the problem is
>> probably to re-seat the harddrive.
>
> Jon: as Tejun says, the ICRC errors indicate a problem with the data
> cabling or connections between the drive and the controller.  Replug,
> clean, examine (and perhaps replace) SATA cables and/or connectors. The
> SMART error log (smartctl -L) might also show entries for the ICRC
> errors
> (with timestamps that might be useful).
>
>> Bruce, I don't think this is SMART related.  Sorry about the noise.
>> Thanks.
>
> Tejun: thank you again, no worries, and definitely no apologies needed!
>
> Cheers,
> 	Bruce
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Smartmontools-support mailing list
> Smartmontools-support@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/smartmontools-support
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

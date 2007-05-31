From: "sam song" <sam_song@usish.com>
Subject: Re: Adaptec RAID 1200A (Highpoint
	HPT370A)access problem
Date: Thu, 31 May 2007 09:45:12 +0800
Message-ID: <003301c7a325$6094cb30$5f39a8c0@usish.com.cn>
References: <001501c79f46$d78fc880$6501a8c0@k7n>
	<465DA6F4.7020203@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <smartmontools-support-bounces@lists.sourceforge.net>
In-Reply-To: <465DA6F4.7020203@t-online.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=smartmontools-support>
List-Post: <mailto:smartmontools-support@lists.sourceforge.net>
List-Help: <mailto:smartmontools-support-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=subscribe>
Sender: smartmontools-support-bounces@lists.sourceforge.net
Errors-To: smartmontools-support-bounces@lists.sourceforge.net
To: 'Christian Franke' <Christian.Franke@t-online.de>, 'BitBucket' <file1303@gmail.com>
Cc: linux-ide@vger.kernel.org, smartmontools-support@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org

> This controller's driver is likely implemented as a SCSI miniport
> driver. These usually don't support SMART, even if the RAID
> functionality is not used.
> http://smartmontools.sourceforge.net/#FAQ-win-ata-as-scsi
> 
> Christian

Hello Christian,

May you confirm the conclusion for Adaptec 3085/3805 RAID controller under
Linux platform? If I need to access SMART data of SATA Disk behind it, is it
a MUST to do some work on its Linux driver?

Thanks in advance,

Sam


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

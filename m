From: Tim Gardner <tim.gardner@canonical.com>
Subject: Re: ata: blacklist FUJITSU MHW2160BH PL
Date: Thu, 06 May 2010 08:48:52 +0200
Message-ID: <4BE26654.5030903@canonical.com>
References: <20100504163257.5DFE5F899A@sepang.rtg.net>
	<4BE20052.8000902@gmail.com>
Reply-To: tim.gardner@canonical.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-team-bounces@lists.ubuntu.com>
In-Reply-To: <4BE20052.8000902@gmail.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
	<mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
	<mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Sender: kernel-team-bounces@lists.ubuntu.com
Errors-To: kernel-team-bounces@lists.ubuntu.com
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org, Kernel team list <kernel-team@lists.ubuntu.com>, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

On 05/06/2010 01:33 AM, Robert Hancock wrote:
> On 05/04/2010 10:32 AM, Tim Gardner wrote:
>> From e21186c4fc02cdd1932365d39d1ba7b2e48417f3 Mon Sep 17 00:00:00 2001
>> From: Chuck Short<zulcss@ubuntu.com>
>> Date: Fri, 18 Jan 2008 13:21:16 -0500
>> Subject: [PATCH] ata: blacklist FUJITSU MHW2160BH PL
>>
>> OriginalAuthor: Chuck Short<zulcss@ubuntu.com>
>> BugLink: http://bugs.launchpad.net/bugs/175834
>>
>> Signed-off-by: Chuck Short<zulcss@ubuntu.com>
>> Signed-off-by: Tim Gardner<tim.gardner@canonical.com>
>>
>> Signed-off-by: Ben Collins<ben.collins@canonical.com>
>> ---
>> drivers/ata/libata-core.c | 1 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 49cffb6..3100827 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -4369,6 +4369,7 @@ static const struct ata_blacklist_entry
>> ata_device_blacklist [] = {
>> { "HTS541060G9SA00", "MB3OC60D", ATA_HORKAGE_NONCQ, },
>> { "HTS541080G9SA00", "MB4OC60D", ATA_HORKAGE_NONCQ, },
>> { "HTS541010G9SA00", "MBZOC60D", ATA_HORKAGE_NONCQ, },
>> + { "FUJITSU MHW2160BH PL", "0084001E", ATA_HORKAGE_NONCQ, },
>>
>> /* https://bugzilla.kernel.org/show_bug.cgi?id=15573 */
>> { "C300-CTFDDAC128MAG", "0001", ATA_HORKAGE_NONCQ, },
>
> NACK. The spurious completion detection in AHCI, which the bug report
> said was being triggered, was incorrect and was removed long ago.
>

Thanks - I'll get this patch removed from the Ubuntu 2.6.34 and 
subsequent kernels.

rtg
-- 
Tim Gardner tim.gardner@canonical.com

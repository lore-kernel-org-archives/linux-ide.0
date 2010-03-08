From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 8 Mar 2010 00:38:01 -0500
Message-ID: <87f94c371003072138u14fba545ra327929aaf503b9f@mail.gmail.com>
References: <4B947393.2050002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f202.google.com ([209.85.223.202]:65249 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab0CHFiD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2010 00:38:03 -0500
In-Reply-To: <4B947393.2050002@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

cc'ing Martin Petersen since I believe he is one of the most
knowledgeable kernel hackers on this topic and has been working the
issue for the last year.

On Sun, Mar 7, 2010 at 10:48 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, guys.
>
> It looks like transition to ATA 4k drives will be quite painful and w=
e
> aren't really ready although these drives are already selling widely.
> I've written up a summary document on the issue to clarify stuff as
> it's getting more and more confusing and develop some consensus. =A0I=
t's
> also on the linux ata wiki.
>
> =A0http://ata.wiki.kernel.org/index.php/ATA_4_KiB_sector_issues
>
> I've cc'd people whom I can think of off the top of my head but I
> surely have missed some people who would have been interested. =A0Ple=
ase
> feel free to add cc's or forward the message to other MLs.
> Especially, I don't know much about partitioners so the details there
> are pretty shallow and could be plain wrong. =A0It would be great if
> someone who knows more about this stuff can chime in.
>
> Thanks.
>
> =3D=3D=3D Document follows =3D=3D=3D
>
> ATA 4 KiB sector issues
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Up until recently, all ATA hard drives have been organized in 512 byt=
e
> sectors. =A0For example, my 500 GB or 477 GiB hard drive is organized=
 of
> 976773168 512 byte sectors numbered from 0 to 976773167. =A0This is h=
ow
> a drive communicates with the driver. =A0When the operating system wa=
nts
> to read 32 KiB of data at 1 MiB position, the driver asks the drive t=
o
> read 64 sectors from LBA (Logical block address, sector number) 2048.
>
> Because each sector should be addressable, readable and writable
> individually, the physical medium also is organized in the same sized
> sectors. =A0In addition to the area to store the actual data, each
> sector requires extra space for book keeping - inter-sector space to
> enable locating and addressing each sector and ECC data to detect and
> correct inevitable raw data errors.
>
> As the densities and capacities of hard drives keep growing, stronger
> ECC becomes necessary to guarantee acceptable level of data integrity
> increasing the space overhead. =A0In addition, in most applications,
> hard drives are now accessed in units of at least 8 sectors or 4096
> bytes and maintaining 512 byte granularity has become somewhat
> meaningless.
>
> This reached a point where enlarging the sector size to 4096 bytes
> would yield measurably more usable space given the same raw data
> storage size and hard drive manufacturers are transitioning to 4 KiB
> sectors.
>
> Anandtech has a good article which illustrates the background and
> issues with pretty diagrams[1].
>
>
> Physical vs. Logical
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Because the 512 byte sector size has been around for a very long time
> and upto ATA/ATAPI-7 the sector size was fixed at 512 bytes, the
> sector size assumption is scattered across all the layers -
> controllers or bridge chips snooping commands, BIOSs, boot codes,
> drivers, partitioners and system utilities, which makes it very
> difficult to change the sector size from 512 byte without breaking
> backward compatibility massively.
>
> As a workaround, the concept of logical sector size was introduced.
> The physical medium is organized in 4 KiB sectors but the firmware on
> the drive will present it as if the drive is composed of 512 byte
> sectors thus making the drive behave as before, so if the driver asks
> the hard drive to read 64 sectors from LBA 2048, the firmware will
> translate it and read 8 4 KiB sectors from hardware sector 256. =A0As=
 a
> result, the hard drive now has two sector sizes - the physical one
> which the physical media is actually organized in, and the logical on=
e
> which the firmware presents to the outside world.
>
> A straight forward example mapping between physical sector and LBA
> would be
>
> =A0LBA =3D 8 * phys_sect
>
>
> Alignment problem on 4 KiB physical / 512 logical drives
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> This workaround keeps older hardware and software working while
> allowing the drive to use larger sector size internally. =A0However, =
the
> discrepancy between physical and logical sector sizes creates an
> alignment issue. =A0For example, if the driver wants to read 7 sector=
s
> from LBA 2047, the firmware has to read hardware sector 255 and 256
> and trim leading 7*512 bytes and tailing 512 bytes.
>
> For reads, this isn't an issue as drives read in larger chunks anyway
> but for writes, the drive has to do read-modify-write to achieve the
> requested action. =A0It has to first read hardware sector 255 and 256=
,
> update requested parts and then write back those sectors which can
> cause significant performance degradation[2].
>
> The problem is aggravated by the way DOS partitions[3] have been laid
> out traditionally. =A0For reasons dating back more than two decades,
> they are laid out considering something called disk geometry which
> nowadays are arbitrary values with a number of restrictions for
> backward compatibility accumulated over the years. =A0The end result =
is
> that until recently (most Linux variants and upto Windows XP) the
> first partition ends up on sector 63 and later ones on cylinder
> boundaries where each cylinder usually is composed of 255 * 63
> sectors.
>
> Most modern filesystems generate 4 KiB aligned accesses from the
> partition it is in. =A0If a drive maps 4 KiB physical sectors to 512
> byte logical sectors from LBA0, the filesystem in the first partition
> will always be misaligned and filesystems in later partitions are
> likely to be misaligned too.
>
>
> Solving the alignment problem on 4 KiB physical / 512 logical drives
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> There are multiple ways which attempt to solve the problem.
>
> S-1. Yet another workaround from the firmware - offset-by-one.
>
> =A0Yet another workaround which can be done by the firmware is to
> =A0offset physical to logical mapping by one logical sector such that
> =A0LBA 63 ends up on physical sector boundary, which aligns the first
> =A0partition to physical sectors without requiring any software updat=
e.
> =A0The example mapping between phys_sector and LBA becomes
>
> =A0 =A0LBA =3D 8 * phys_sect - 1
>
> =A0The leading 512 bytes from phys_sect 0 is not used and LBA 0 start=
s
> =A0from after that point. =A0phys_sect 1 maps to LBA 7 and phys_sect =
8 to
> =A063, making LBA 63 aligned on hardware sector.
>
> =A0Although this aligns only the first partition, for many use cases,
> =A0especially the ones involving older software, this workaround was
> =A0deemed useful and some recent drives with 4 KiB physical sectors a=
re
> =A0equipped with a dip switch to turn on or off offset-by-one mapping=
=2E
>
> S-2. The proper solution.
>
> =A0Correct alignments for all partitions can't be achieved by the
> =A0firmware alone. =A0The system utilities should be informed about t=
he
> =A0alignment requirements and align partitions accordingly.
>
> =A0The above firmware workaround complicates the situation because th=
e
> =A0two different configurations require different offsets to achieve
> =A0the correct alignments. =A0ATA/ATAPI-8 specifies a way for a drive=
 to
> =A0export the physical and logical sector sizes and the LBA offset
> =A0which is aligned to the physical sectors.
>
> =A0In Linux, these parameters are exported via the following sysfs
> =A0nodes.
>
> =A0 =A0physical sector size =A0 =A0 =A0 =A0: /sys/block/sdX/queue/phy=
sical_block_size
> =A0 =A0logical sector size =A0 =A0 =A0 =A0 : /sys/block/sdX/queue/log=
ical_block_size
> =A0 =A0alignment offset =A0 =A0 =A0 =A0 =A0 =A0: /sys/block/sdX/align=
ment_offset
>
> =A0Let the physical sector size be PSS, logical sector size LSS and
> =A0alignment offset AOFF. =A0The system software should place partiti=
ons
> =A0such that the starting LBAs of all partitions are aligned on
>
> =A0 =A0(n * PSS + AOFF) / LSS
>
> =A0For 4 KiB physical sector offset-by-one drives, PSS is 4096, LSS 5=
12
> =A0and AOFF 3584 and with n of 7 the above becomes,
>
> =A0 =A0(7 * 4096 + 3584) / 512 =3D=3D 63
>
> =A0making sector 63 an aligned LBA where the first partition can be
> =A0put, but without the offset-by-one mapping, AOFF is zero and LBA 6=
3
> =A0is not aligned.
>
> =A0With the above new alignment requirement in place, it becomes
> =A0difficult to honor the legacy one - first partition on sector 63 a=
nd
> =A0all other partitions on cylinder boundary (255 * 63 sectors) - as
> =A0the two alignment requirements contradict each other. =A0This migh=
t be
> =A0worked around by adjusting how LBA and CHS addresses are mapped bu=
t
> =A0the disk geometry parameters are hard coded everywhere and there i=
s
> =A0no reliable way to communicate custom geometry parameters.
>
>
> Complications
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Unfortunately, there are complications.
>
> C-1. The standard is not and won't be followed as-is.
>
> =A0Some of the existing BIOSs and/or drivers can't cope with drives
> =A0which report 4 KiB physical sector size. =A0To work around this, s=
ome
> =A0drive models lie that its physical sector size is 512 bytes when t=
he
> =A0actual configuration is 4 KiB without offsetting.
>
> =A0This nullifies the provisions for alignment in the ATA standard bu=
t
> =A0results in the correct alignment for Windows Vista and 7. =A0OS
> =A0behaviors will be described further later.
>
> =A0For these drives, which are likely to continue to be shipped for t=
he
> =A0foreseeable future, traditional LBA 63 and cylinder based aligning
> =A0results in misalignment.
>
> C-2. Windows XP depends on the traditional partition layout.
>
> =A0Windows XP makes use of the CHS start/end addresses in the partiti=
on
> =A0table and gets confused if partitions are not laid out
> =A0traditionally. =A0This means that XP can't be installed into a
> =A0partition prepared by later versions of Windows[4]. =A0This isn't =
a
> =A0big problem for Windows because in most cases the later version is
> =A0replacing the older one, not the other way around.
>
> =A0Unfortunately, the situation is more complex for Linux because Lin=
ux
> =A0is often co-installed with various versions of Windows and XP is
> =A0still quite popular. =A0This means that when a Linux partitioner i=
s
> =A0used to prepare a partition which may be used by Windows, the
> =A0partitioner might have to consider which version of Windows is goi=
ng
> =A0to be used and whether to align the partitions for the correct
> =A0alignment or compatibility with older versions of Windows.
>
> C-3. The 2 TiB barrier and the possibility for 4 KiB logical sector s=
ize.
>
> =A0The DOS partition format uses 32 bit for the starting LBA and the
> =A0number of sectors and, reportedly, 32 bit Windows XP shares the
> =A0limitation. =A0With 32 bit addressing and 512 byte logical sector
> =A0size, the maximum addressable sector + 1 is at
>
> =A0 =A02^32 * 2^9 =3D=3D 2^41 =3D=3D 2 TiB
>
> =A0The DOS partition format allows a partition to reach beyond 2 TiB =
as
> =A0long as the starting LBA is under 2 TiB; however, both Windows XP
> =A0and and the Linux kernel (at least upto v2.6.33) refuse such
> =A0partition configurations.
>
> =A0With the right combination of host controller, BIOS and driver, th=
is
> =A0barrier can be overcome by enlarging the logical sector size to 4
> =A0KiB, which will push the barrier out to 16 TiB. =A0On the right
> =A0configuration, Windows XP is reportedly able to address beyond the=
 2
> =A0TiB barrier with a DOS partition and 4 KiB logical sector size.
> =A0Linux kernel upto v2.6.33 doesn't work under such configurations b=
ut
> =A0a patch to make it work is pending[5].
>
> =A0This might also be beneficial for operating systems which don't
> =A0suffer from this limitation. =A0A different partition format - GPT=
[6]
> =A0- should be used beyond 2^32 sectors, which could harm compatibili=
ty
> =A0with older BIOSs or other operating systems which don't recognize
> =A0the new format.
>
> =A0As mentioned previously, 512 byte sector assumption has been there
> =A0for a very long time and changing it is likely to cause various
> =A0compatibility problems at many different layers from hardware up t=
o
> =A0the system utilities.
>
>
> Windows
> =3D=3D=3D=3D=3D=3D=3D
>
> As hard drive vendors aim for performance and compatibility in modern
> Windows environments, it is worthwhile to investigate how Windows
> partitions with different alignment requirements. =A0Up until Windows
> XP, it followed the traditional layout - the first partition on LBA 6=
3
> and the others on cylinder boundaries where a cylinder is defined as
> 255 tracks with 63 sectors each.
>
> Windows Vista and 7 align partitions differently. =A0As the two behav=
e
> similarly, only 7's behavior is shown here. =A0These partition tables
> are created by Windows 7 RC installer on blank disks.
>
> W-1. 512 byte physical and logical sector drive.
>
> =A0ST FIRST =A0T =A0LAST =A0 LBA =A0 =A0 =A0NBLKS
> =A080 202100 07 df130c 00080000 00200300
> =A000 df140c 07 feffff 00280300 00689e12
> =A000 000000 00 000000 00000000 00000000
> =A000 000000 00 000000 00000000 00000000
>
> =A0Part0: =A0 =A0 =A0 =A0FIRST =A0 C =A0 =A00 =A0H =A0 32 =A0S =A0 33=
 =A0: 2048 =A0 =A0 =A0 =A0 =A0(63 sec/trk)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LAST =A0 =A0C =A0 12 =A0H =A0223 =A0S =
=A0 19 =A0: 206847 =A0 =A0 =A0 =A0(255 heads/cyl)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LBA =A0 =A0 2048 + 204800 =3D 206848
>
> =A0Part1: =A0 =A0 =A0 =A0FIRST =A0 C =A0 12 =A0H =A0223 =A0S =A0 20 =A0=
: 206848
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LAST =A0 =A0C 1023 =A0H =A0254 =A0S =A0=
 63 =A0: E
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LBA =A0 =A0 206848 + 312371200 =3D 312=
578048
>
> =A0Both aligned at (2048 * n). =A0Part 1 not aligned to cylinder.
>
> W-2. 4 KiB physical and 512 byte logical sector drive without offset-=
by-one.
>
> =A0ST FIRST =A0T =A0LAST =A0 LBA =A0 =A0 =A0NBLKS
> =A080 202100 07 df130c 00080000 00200300
> =A000 df140c 07 feffff 00280300 00b83f25
> =A000 000000 00 000000 00000000 00000000
> =A000 000000 00 000000 00000000 00000000
>
> =A0Part0: =A0 =A0 =A0 =A0FIRST =A0 C =A0 =A00 =A0H =A0 32 =A0S =A0 33=
 =A0: 2048 =A0 =A0 =A0 =A0 =A0(63 sec/trk)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LAST =A0 =A0C =A0 12 =A0H =A0223 =A0S =
=A0 19 =A0: 206847 =A0 =A0 =A0 =A0(255 heads/cyl)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LBA =A0 =A0 2048 + 204800 =3D 206848
>
> =A0Part1: =A0 =A0 =A0 =A0FIRST =A0 C =A0 12 =A0H =A0223 =A0S =A0 20 =A0=
: 206848
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LAST =A0 =A0C 1023 =A0H =A0254 =A0S =A0=
 63 =A0: E
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LBA =A0 =A0 206848 + 624932864 =3D 625=
139712
>
> =A0Both aligned at (2048 * n). =A0Part 1 not aligned to cylinder.
>
> W-3. 4 KiB physical and 512 byte logical sector drive with offset-by-=
one.
>
> =A0ST FIRST =A0T =A0LAST =A0 LBA =A0 =A0 =A0NBLKS
> =A080 202800 07 df130c 07080000 f91f0300
> =A000 df1b0c 07 feffff 07280300 f9376d74
> =A000 000000 00 000000 00000000 00000000
> =A000 000000 00 000000 00000000 00000000
>
> =A0Part0: =A0 =A0 =A0 =A0FIRST =A0 C =A0 =A00 =A0H =A0 32 =A0S =A0 40=
 =A0: 2055 =A0 =A0 =A0 =A0 =A0(63 sec/trk)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LAST =A0 =A0C =A0 12 =A0H =A0223 =A0S =
=A0 19 =A0: 206847 =A0 =A0 =A0 =A0(255 heads/cyl)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LBA =A0 =A0 2055 + 204793 =3D 206848
>
> =A0Part1: =A0 =A0 =A0 =A0FIRST =A0 C =A0 12 =A0H =A0223 =A0S =A0 27 =A0=
: 206855
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LAST =A0 =A0C 1023 =A0H =A0254 =A0S =A0=
 63 =A0: E
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LBA =A0 =A0 206855 + 1953314809 =3D 19=
53521664
>
> =A0Both aligned at (2048 * n + 7). =A0Part 1 not aligned to cylinder.
>
> The partitioner seems to be using 1M as the basic alignment unit and
> offsetting from there if explicitly requested by the drive and there
> is no difference between handling of 512 byte and 4 KiB drives, which
> explains why C-1 works for hard drive vendors.
>
> In all cases, the partitioner ignores both the first partition on LBA
> 63 and the others on cylinder boundary requirements while still using
> the same 255*63 cylinder size. =A0Also, note that in W-3, both part 0
> and 1 end up with odd number of sectors. =A0It seems that they simply
> decided to completely break away from the traditional layout, which i=
s
> understandable given that there really isn't one good solution which
> can cover all the cases and that the default larger alignment benefit=
s
> earlier SSDs.
>
> Windows Vista basically shows the same behavior. =A0Vista was tested =
by
> creating two partitions using the management tool. =A0Test data is
> available at [7].
>
> =A0*-alignment_offset =A0 =A0: alignment_offset reported by Linux ker=
nel
> =A0*-fdisk =A0 =A0 =A0 =A0 =A0 =A0 =A0 : fdisk -l output
> =A0*-fdisk-u =A0 =A0 =A0 =A0 =A0 =A0 : fdisk -lu output
> =A0*-hdparm =A0 =A0 =A0 =A0 =A0 =A0 =A0: hdparm -I output
> =A0*-mbr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : dump of mbr
> =A0*-part =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: decoded partition table fr=
om mbr
>
> Please note that hdparm is misreporting the alignment offset. =A0It
> should be reporting 512 instead of 256 for offset-by-one drives.
>
>
> So, what now for Linux?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The situation is not easy. =A0Considering all the factors, the only
> workable solution looks like doing what Windows is doing. =A0Hard dri=
ve
> and SSD vendors are focusing on compatibility and performance on
> recent Windows releases and are happy to do things which break the
> standard defined mechanism as shown by C-1, so parting away from what
> Windows does would be unnecessarily painful.
>
> Unfortunately, while Windows can assume that newer releases won't
> share the hard drive with older releases including Windows XP, Linux
> distros can't do that. =A0There will be many installations where a
> modern Linux distros share a hard drive with older releases of
> Windows. =A0At this point, I can't see a silver bullet solution.
>
> Partitioners maybe should only align partitions which will be used by
> Linux and default to the traditional layout for others while allowing
> explicit override. =A0I think Windows XP wouldn't have problem with
> differently aligned partitions as long as it doesn't actually use the=
m
> but haven't tested it.
>
> Reportedly, commonly used partitioners aren't ready to handle drives
> larger than 2 TiB in any configuration and alignment isn't done
> properly for drives with 4 KiB physical sectors. =A04 KiB logical sec=
tor
> support is broken in both the kernel and partitioners. =A0(need more
> details and probably a whole section on partitioner behaviors)
>
> Unfortunately, the transition to 4 KiB sector size, physical only or
> logical too, is looking fairly ugly. =A0Hopefully, a reasonable solut=
ion
> can be reached in not too distant future but even with all the
> software side updated, it looks like it's gonna cause significant
> amount of confusion and frustration.
>
>
> [1] http://www.anandtech.com/storage/showdoc.aspx?i=3D3691
> [2] http://www.osnews.com/story/22872/Linux_Not_Fully_Prepared_for_40=
96-Byte_Sector_Hard_Drives
> [3] http://en.wikipedia.org/wiki/Master_boot_record
> [4] http://support.microsoft.com/kb/931760
> [5] http://thread.gmane.org/gmane.linux.kernel/953981
> [6] http://en.wikipedia.org/wiki/GUID_Partition_Table
> [7] http://userweb.kernel.org/~tj/partalign/
>
> * Mar 04 2009
> =A0 =A0 =A0 =A0Initial draft, Tejun Heo <tj@kernel.org>
> * Mar 08 2009
> =A0 =A0 =A0 =A0Updated according to comments from Daniel Taylor
> =A0 =A0 =A0 =A0<Daniel.Taylor@wdc.com>. =A0Other minor updates.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
Preservation and Forensic processing of Exchange Repositories White Pap=
er -
<http://www.norcrossgroup.com/forms/whitepapers/tng_whitepaper_fpe.html=
>

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com

From: Steve Rosenbluth <conceptoverdrive@sbcglobal.net>
Subject: Re: SATA 2.4 ICH8
Date: Sun, 18 May 2008 23:08:02 -0700
Message-ID: <48311942.8000407@sbcglobal.net>
References: <480B925B.1080408@sbcglobal.net> <20080424221143.GB20775@1wt.eu>
Reply-To: steve@conceptoverdrive.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010500060000020409030204"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:38253 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750702AbYESGOo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 02:14:44 -0400
In-Reply-To: <20080424221143.GB20775@1wt.eu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010500060000020409030204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Willie,

Attached is the patch you asked for (ICH8 SATA controller definition).
I have also supplied two other patches for 2.4.36.4

 From the enclosed README :

"The following patches are for kernel 2.4.36.4 sources
obtained from kernel.org :

intel_sata_ich8.patch
This patches drivers/scsi/ata_piix.c
It allows the kernel to access a SATA drive on an Intel ICH8 controller
using the ich7 driver. This has been tested and it seems quite stable.

sigset_cast.patch
This patches include/linux/signal.h
There is an implicit cast from an integer to an
unsigned long (sigset_t) which causes compilers to generate warnings.
Different compilers could possibly produce different code.
This change has been tested over several years of use and is stable.

processor_colons_gcc-2.95.3.patch
This patches include/asm/processor.h
Sometime between 2.4.29 and 2.4.36.2 spaces were deleted between colons
which causes compiler gcc 2.95.3 to fail to parse the header
when compiling applications which include it.
Adding back the spaces solves the problem on gcc 2.95.3.
gcc 4.1.1 also compiles the kernel OK with this patch."

Cheers,
-Steve

Willy Tarreau wrote:
> Hi Steve,
> 
> On Sun, Apr 20, 2008 at 11:58:35AM -0700, Steve Rosenbluth wrote:
> 
>>Hi Willy,
>>
>>I got another Intel 965 82801H ICH8 chipset SATA interface working with 
>>the 2.4.36.2 kernel.
>>
>>In ata_piix.c I added to pci_device_id piix_pci_tbl[] the following PCI ID :
>>{ 0x8086, 0x2829, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
>>
>>I was able to boot the kernel OK from the SATA drive, but I did not do 
>>any stress testing.
>>
>>I understand that you are not adding laptop chipsets, like mine, to 2.4, 
>>but I thought you would like to know that it works. Perhaps there ought 
>>to be a contrib driver web page somewhere detailing such information.
> 
> 
> I already have such a page (though it has not been updated for a while) :
> 
>    http://linux.1wt.eu/kernel/2.4/lkup/
> 
> However, I've already queued a few minor patches in case I finally open
> 2.4.37. The more I accumulate, the more reason I will get to open it. If
> you provide me with a patch, I'll queue it and it will contribute to my
> will to open 2.4.37 :-)
> 
> Regards,
> Willy
> 
> 


-- 
Steve Rosenbluth


--------------010500060000020409030204
Content-Type: application/x-gzip;
 name="patches_for_2.4.36.4_sr.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patches_for_2.4.36.4_sr.tgz"

H4sIAEC0MEgAA+1YbW/jNgzu1/hXEB0wJJfYkR07Tl1saHEttmJYW7QdhmEYDMVWEqGO5ZPk
pt2h/32Uk/TlmjTXa3eHYX76IsciKZIiKSoF1cmEqXgkZOw5vtPrO36sZHfrDUGIT8IgwLHC
p2P17LrE9V0v6Lv+FnF7QY9sQfCWSqxDqTSVAFtSCP0c3ab5/yiKNfvPc82yWFFNY55MBk5F
94VrEJeQvu+v23+cdZf77/eq/Q+DEPefvKmla/A/33/btiHjeXltL3e/m0p+xaTqqkTxrgmA
gvNrJ2l4hAxsEtikD24/IiTydpy7BAabhIRY7XZ7Lm6jFHcAbhCRXtR7KmVvD2zXDTt9aJsh
hL09CxofgVwPyKDfwdELE78Dp++P4v3jP+Kjg8fPpPrFuA2rCIbbzqfsA4+8jj14EXv7U/ad
16zeH2xUnqmhd89eCbhtdN+BZnLKc6oZ7pLS8K5rfesArPFNsa7+F1IkTCl8m4hM5CoeJwmW
iJ3A6b34LNhQ/3Gud3f+90LsEzw38Ny6/n8NrKj/PE+yMmVdqqY27w3697HgTF54CHyWqPlJ
4IaR11t5Evg7AR4B7flgTgKsY2eHp3B8cgrN0/3fzg9bwBVQGAuRgp7wfAxaAM8VkxoHfB6W
6saeUa4hE6JQjil8gBuveYIEqCuDK8FTkKyIc1E0zYeWBR8tuxHHqHwcQxxfiQwZMhbHzW0k
3EXCbYiiCLanbCrkzXZrFwv98/QR4M8Derg11fm7lI2MDklRxpJl9LrZaixVaf27FXpd/is+
VkzHCVX6Vb2fwcb+Lwzv8p/0XdP/kSCs8/9r4Jn8n6cwBkJOsy/O/DVCFjnvRUG4uvvrk84A
u79qqLo/TBFaZjrCxwbmDwZnE/86SNoBxf9mYtRcxKxumcRqNIaS0ctdTGEMYgZeBDhp/4hE
f7p/wQ/IeDfnRo27ObKca6/ha5a5MYelWEvycesB6RMxK0jv9YLGrUl/Y61HfFPh5sM6a79/
oMYjsyvZ75rx8fnRT/HvJ2cH57b7+S54gZmwNBPutP/W4VvjlVhX/88O9w9+PXybNTbV/9Dz
F/W/5xEX+z/X94lX1/+vgYsJg5HIMjEzbdMiGoBK81bCJZM5y2AZGKBEKbF/A0sMNeWmOIyk
mC7IHCHHEFnWyq+OrIsJ9mhL+Wu+HLCONFCji8I2ji1Xx/6NJqZrxBbvfP9if84NIgeaw5FZ
DI7e/zyARORaoilMWqWqmkCUYe7Ri+UcqHSYUAVDxnK8CyuNFtA8BWwMFcMyCx9KjndjDIlh
xhzLetIFPTZj9SGHNAz9Z1rSHPi0yHiC8o2MubfMW9R6zGRlWg7Wo1IL9+cYzCaoP7KWCldL
xLTAdlIqwzZmOZPmHj+jMkdjlWMd8NEIF871A8pElFkKhVCKD7MbwPY7LRMG6QPSFA2trEom
NB+zJ/4R6Dr0Dv6nGdwwilLFCFCjuefUvbc23hlXew/75Yf3AutcTJnmU4Za6JlRxISft1Mt
t4hED1RBTSDOjKdTljGj6ZJ+vrq10nmAOsFcJ+PGEeVVgBVoFqsCZsJoimTIXUkyXCaWaGH2
Eft5lLzYloX+GDwOWPtpasiGNLmsxCz0UyK7YvNoRhPRTVMTt/c6OJZ59h3XcTHylVjq+SgB
Tn6BGdcTc7VZeA+dbZ9r3BM4E4rlw6zEadNbkcAd1IdyjRo1atSoUaNGjRo1atSoUeMR/gEG
L66kACgAAA==
--------------010500060000020409030204--

From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: IDE CDROM tail read errors
Date: Tue, 04 Apr 2006 15:09:20 -0400
Message-ID: <4432C460.3080606@tmr.com>
References: <m3wtedrrpf.fsf@defiant.localdomain> <1143717489.29388.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751320AbWDES0y@vger.kernel.org>
In-Reply-To: <1143717489.29388.32.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Mer, 2006-03-29 at 21:11 +0200, Krzysztof Halasa wrote:
>> # ls -l
>> -rw-r--r-- 1 root root 687177728 Mar 29 15:51 img-15.iso
>> -rw-r--r-- 1 root root 687177728 Mar 29 15:58 img-15a.iso
>>
>> The files are just truncated FC5d1 images (57344 bytes missing).
> 
> The final partial read is dropped rather than partially completed.
> 
>> # cat /sys/block/sr0/size
>> 1342264 (i.e., the same as with 2.6.15 + drivers/ide)
>>
>> # cat /dev/cdrw > img-16a.iso
>> cat: /dev/cdrw: Input/output error
>>
>> # cat /sys/block/sr0/size
>> 1342256 (looks like it has been adjusted to .iso image size / 512 when
>>          the first I/O error occured)
> 
> The SCSI layer does this bit for everyone. Its actually not libata or
> the PATA drivers that have done the work here. You should find ide-scsi
> does the same.
> 
> I patched the old IDE driver a bit to try and deal with this and if you
> want the patch to hack on and tidy up further feel free. 
> 
> 
Any hope in hell of getting this fixed? It's been broken for too long to 
remember. IIRC the problem is that on a read which hits EOF, instead of 
returning partial data read and no error, the status returned is just 
some "didn't work" variant and the partial read is lost. I also seem to 
remember that if the length of the ISO was a multiple of a magic number, 
32k, or the metric hexadecimal phase of the moon, you got a clean EOF.

As you say, ide-scsi fixes this, if the people who don't like it would 
make the alternatives work right it wouldn't be an issue...

Thanks for the info.
